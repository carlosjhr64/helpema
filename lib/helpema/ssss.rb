module Helpema
module SSSS
class << self
  attr_accessor :version
  SSSS.version = 'Version: 0\.[567]\b' # version as of this writing is 0.5

  # def split(secret:, threshold:2, shares:3, token:nil, level:nil, hexmode:false)
  # @type method Helpema::SSSS.split: (**untyped) -> Array[String]?
  define_command(:split,
    cmd: 'ssss-split', v: SSSS.version,
    usage: {Q:true,t:2,n:3,w:nil,s:nil,x:false},
    synonyms: {threshold: :t, shares: :n, token: :w,  level: :s, hexmode: :x},
    mode: 'w+', exception: 'ssss-split failed.',
    err: [:child, :out]
  ) do |pipe, options, blk|
    pipe.puts options.fetch(:secret)
    pipe.read.split.last(options[:shares])
  end

  # NOTE: threshold=secrets.length
  # def combine(secrets:, threshold:2, hexmode:false)
  # @type method Helpema::SSSS.combine: (**untyped) -> String?
  define_command(:combine,
    cmd: 'ssss-combine', v: SSSS.version,
    usage: {Q:true,t:2,x:false}, synonyms: {threshold: :t, hexmode: :x},
    mode: 'w+', exception: 'ssss-combine failed.',
    err: [:child, :out]
  ) do |pipe, options, blk|
    options.fetch(:secrets).each{pipe.puts _1}
    pipe.read.lines.last.chomp
  end
end
end
end
