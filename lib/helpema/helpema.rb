module Helpema
  refine ::String do
    def satisfies?(*reqs)
      Gem::Requirement.new(*reqs).satisfied_by? Gem::Version.new(self)
    end
  end
  refine ::Hash do
    def to_args(usage:nil, synonyms:nil)
      # create separate args from self with the translated synonyms
      args = self.transform_keys{synonyms&.[](_1) || _1}
      # pad usage's defaults to args
      usage&.each{|key,default| args[key]=default unless args.has_key? key}
      # order might be important so enforce usage
      args = usage ? usage.map{|k,v|[k,args[k]]} : args.to_a
      # convert key,value tuples to final list of args
      args.map!(&:to_arg)
      # get rid of nils
      args.select!{_1}
      # ...and finally flatten!
      args.flatten!
      return args
    end
  end
  refine ::Array do
    def classify(hash: Hash.new{|h,k|h[k]=[]}, &block)
      self.each{|v| hash[v.class] << v}
      return block ? block.call(hash) : hash
    end
    def to_arg
      Helpema.to_arg(*self)
    end
  end
  refine ::Symbol do
    def to_flag
      return nil if self[-1].match?(/\d/) # like :arg0
      (self.length > 1)? "--#{self}": "-#{self}" # like --verbose or -V
    end
  end
  using Helpema

  def to_arg(key,value)
    # keep only keys with value(no falses or nils)
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
      ret = (forward_pass)? forward_pass.call(pipe, options, blk): (blk)? blk.call(pipe): pipe.read
    end
    (exception.nil? or $?.exitstatus==0)? ret : raise(exception)
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

  def requires(*list)
    loaded = []
    list.each do |gems|
      gems.lines.each do |gemname_reqs|
        gemname, *reqs = gemname_reqs.split
        next unless gemname
        unless reqs.empty?
          case gemname
          when 'helpema'
            raise "helpema #{VERSION} not #{reqs.join(', ')}" unless VERSION.satisfies?(*reqs)
            next
          when 'ruby'
            raise "ruby #{RUBY_VERSION} not #{reqs.join(', ')}" unless RUBY_VERSION.satisfies?(*reqs)
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

  extend self
end
