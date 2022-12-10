module Helpema
  module Piper
    module Refinements
      refine ::Hash do
        def to_args(usage:nil, synonyms:nil)
          # create separate args from self with the translated synonyms
          args = self.transform_keys(synonyms.to_h)
          # pad usage's defaults to args
          usage&.each{|key,default| args[key]=default unless args.has_key? key}
          # order might be important so enforce usage
          args = usage&.map{|k,v|[k,args[k]]} || args.to_a
          # convert key,value tuples to final list of args
          args.map!(&:to_arg)
          # get rid of nil
          args.compact!
          # ...and finally flatten!
          args.flatten!
          return args
        end
      end
      refine ::Symbol do
        def to_flag
          return nil if self[-1].match?(/\d/) # like :arg0
          (self.length > 1)? "--#{self}": "-#{self}" # like --verbose or -V
        end
      end
      refine ::Array do
        def to_arg
          Piper.to_arg(*self)
        end
      end
    end

    def Piper.validate_command(cmd, version, flag='--version')
      raise "`#{cmd} #{flag}` !~ #{version}" unless
      `#{cmd} #{flag}`.strip.match?(version)
    end

    # Note: popt is IO.popen's options(think of it as "pipe's options").
    def define_command(name,
                       cmd:name.to_s.chomp('?').chomp('!'),
                       version:nil, v:nil,
                       usage:nil,   synonyms:nil,
                       mode:'r',    exception:nil, default:nil,
                       **popt,      &forward_pass)
      raise "bad name or cmd" unless name=~/^\w+[?!]?$/ and cmd=~/^[\w.\-]+$/
      Piper.validate_command(cmd, version) if version
      Piper.validate_command(cmd, v, '-v') if v
      define_method(name) do |script=default, **options, &blk|
        if mode[0]=='w'
          raise 'need script to write' unless script or blk or forward_pass
        else
          raise 'cannot write script' if script
        end
        Piper.run_command(cmd, options, script:script,
          usage:usage, synonyms:synonyms, mode:mode,
          exception:exception, forward_pass:forward_pass, **popt, &blk)
      end
    end

    using Refinements

    def Piper.to_arg(key,value)
      # keep only keys with value(no false or nil)
      return nil unless value
      # assume nil0/--long/-short
      key = key.to_flag
      if key
        return key if value==true # a flag
        return "#{key}#{value}" if key[-1]=='=' # joined key=value
        return [key,value.to_s]
      end
      # It's a Nth arg, like arg0...
      return value.to_s
    end

    # Assume caller knows what it's doing(no dummy proofing here)
    def Piper.run_command(cmd, options={}, script:nil,
      usage:nil, synonyms:nil, mode:'r',
      exception:nil, forward_pass:nil, **popt, &blk)
      args,ret = options.to_args(usage:usage,synonyms:synonyms),nil
      $stderr.puts "#{cmd} #{args.join(' ')}" if $DEBUG
      IO.popen([cmd, *args], mode, **popt) do |pipe|
        pipe.write script if script
        if forward_pass
          ret = forward_pass.call(pipe, options, blk)
        elsif blk
          ret = blk.call(pipe, options)
        elsif mode=='r'
          ret = pipe.read
        elsif mode=='w+'
          pipe.close_write
          ret = pipe.read
        end
      end
      # False exception instead of nil or "an error message"
      # flags the expected behavior as defined:
      success = ($?.exitstatus==0)
      raise(exception) if exception and not success
      return success if exception==false
      return ret
    end
  end
end
