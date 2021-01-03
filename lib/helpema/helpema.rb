module Helpema
  refine ::Symbol do
    def to_opt
      return nil if self[-1].match?(/\d/) # like :arg0
      (self.length > 1)? "--#{self}": "-#{self}" # like --verbose or -V
    end
  end
  refine ::String do
    def satisfies?(*reqs)
      Gem::Requirement.new(*reqs).satisfied_by? Gem::Version.new(self)
    end
  end
  refine ::Array do
    def classify(hash: Hash.new{|h,k|h[k]=[]}, &block)
      self.each{|v| hash[v.class] << v}
      return block ? block.call(hash) : hash
    end
  end
  using Helpema

  def requires(*list)
    loaded = []
    list.each do |gems|
      gems.lines.each do |gemname_reqs|
        gemname, *reqs = gemname_reqs.split
        next unless gemname
        unless reqs.empty?
          case gemname
          when 'helpema'
            raise "helpema(#{VERSION}) not #{reqs.join(', ')}" unless VERSION.satisfies?(*reqs)
            next
          when 'ruby'
            raise "ruby(#{RUBY_VERSION}) not #{reqs.join(', ')}" unless RUBY_VERSION.satisfies?(*reqs)
            next
          else
            gem gemname, *reqs
          end
        end
        require gemname and loaded.push gemname
      end
    end
    return loaded
  end

  def to_opt(key,value)
    # keep only keys with value(no falses or nils)
    return nil unless value
    # assume nil0/--long/-short
    key = key.to_opt
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
    exception:nil, opt:{}, forward_pass:nil, &blk)
    ret = nil

    # create separate args for cmd and replace synonyms
    args = options.transform_keys{synonyms&.[](_1) || _1}
    # pad defaults to args
    usage&.each{|key,default| args[key]=default unless args.has_key? key}
    # order might be important
    args = usage ? usage.map{|k,v|[k,args[k]]} : args.to_a
    # convert key,value to final list of args
    args.map!{to_opt(_1,_2)}
    args.select!{_1}
    args.flatten!

    $stderr.puts "#{cmd} #{args.join(' ')}" if $DEBUG
    IO.popen([cmd, *args], mode, **opt) do |pipe|
      ret = (forward_pass)? forward_pass.call(pipe, options, blk): (blk)? blk.call(pipe): pipe.read
    end
    raise exception unless exception.nil? or $?.exitstatus==0

    ret
  end

  def define_command(name,
    cmd: name.to_s, version: nil, v: nil,
    usage: nil, synonyms: nil,
    mode: 'r',exception: nil,
    **opt, &forward_pass)

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
        exception:exception, opt: opt, forward_pass:forward_pass, &blk)
    end
  end

  extend self
end
