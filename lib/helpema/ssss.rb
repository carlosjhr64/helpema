module Helpema
module SSSS
class << self
  attr_accessor :version
  SSSS.version = 'Version: 0\.[567]\b' # version as of this writing is 0.5

  # def split(secret: : String, shares:3 Integer, threshold:2 Integer,
  #           token:nil (NilClass | String), level:nil (NilClass | Integer), hexmode:false (FalseClass | TrueClass))
  #           => {}?(Array(String))
  define_command(:split,
    cmd: 'ssss-split', v: SSSS.version,
    usage: {Q:true,t:2,n:3,w:nil,s:nil,x:false},
    synonyms: {threshold: :t, shares: :n, token: :w,  level: :s, hexmode: :x},
    mode: 'w+', exception: 'ssss-split failed.',
    err: [:child, :out]
  ) do |pipe, options, blk|
    pipe.puts options.fetch(:secret)
    _ = pipe.read.split.last(options[:shares])
    (blk)? blk.call(_): _
  end

  # def combine(secrets: : Array(String), threshold:2 : Integer,
  #             hexmode:false (FalseClass | TrueClass))
  #             => {}?(String)
  define_command(:combine,
    cmd: 'ssss-combine', v: SSSS.version,
    usage: {Q:true,t:2,x:false}, synonyms: {threshold: :t, hexmode: :x},
    mode: 'w+', exception: 'ssss-combine failed.',
    err: [:child, :out]
  ) do |pipe, options, blk|
    options.fetch(:secrets).each{pipe.puts _1}
    _ = pipe.read.lines.last.chomp
    (blk)? blk.call(_): _
  end
end
end
end
