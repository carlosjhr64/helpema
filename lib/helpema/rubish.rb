module Helpema
  module Rubish
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
          Rubish.to_arg(*self)
        end
      end
    end

    def define_command(name,
      cmd: name.to_s, version: nil, v: nil,
      usage: nil, synonyms: nil,
      mode: 'r',exception: nil,
      **popt, &forward_pass)
      # which version? --version or -v
      if version and not `#{cmd} --version`.strip.match?(version)
        raise "`#{cmd} --version` !~ #{version}"
      end
      if v and not `#{cmd} -v`.strip.match?(v)
        raise "`#{cmd} -v` !~ #{v}"
      end
      define_method(name) do |**options, &blk|
        run_command(cmd, options,
          usage:usage, synonyms:synonyms, mode:mode,
          exception:exception, forward_pass:forward_pass, **popt, &blk)
      end
    end

    using Refinements

    def Rubish.to_arg(key,value)
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

    def run_command(cmd, options={},
      usage:nil, synonyms:nil, mode:'r',
      exception:nil, forward_pass:nil, **popt, &blk)
      args,ret = options.to_args(usage:usage,synonyms:synonyms),nil
      $stderr.puts "#{cmd} #{args.join(' ')}" if $DEBUG
      IO.popen([cmd, *args], mode, **popt) do |pipe|
        ret = forward_pass ? forward_pass.call(pipe, options, blk) :
                       blk ? blk.call(pipe) :
                             pipe.read
      end
      (exception.nil? or $?.exitstatus==0)? ret : raise(exception)
    end

    extend self
  end
end
