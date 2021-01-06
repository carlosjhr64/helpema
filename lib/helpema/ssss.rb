module Helpema
module SSSS
class << self
  attr_accessor :version
  SSSS.version = 'Version: 0\.[567]\b' # version as of this writing is 0.5

  def split(secret:, threshold:, shares:, token:nil, level:nil, hexmode:false) =
     _split(secret:secret, threshold:threshold, shares:shares, token:token, level:level, hexmode:hexmode)
  define_command(:_split,
    cmd: 'ssss-split', v: SSSS.version,
    usage: {Q:true,t:2,n:3,w:nil,s:nil,x:false},
    synonyms: {threshold: :t, shares: :n, token: :w,  level: :s, hexmode: :x},
    mode: 'w+', exception: 'ssss-split failed.',
    err: [:child, :out]
  ) do |pipe, options, blk|
    pipe.puts options.fetch(:secret)
    pipe.read.split.last(options[:shares])
  end

  def combine(secrets:, threshold:, hexmode:false)
    raise 'Need threshold number of secrets.' unless secrets.size >= threshold
    _combine(secrets:secrets, threshold:threshold, hexmode:hexmode)
  end
  define_command(:_combine,
    cmd: 'ssss-combine', v: SSSS.version,
    usage: {Q:true,t:2,x:false}, synonyms: {threshold: :t, hexmode: :x},
    mode: 'w+', exception: 'ssss-combine failed.',
    err: [:child, :out]
  ) do |pipe, options, blk|
    secrets,n = options.fetch_values(:secrets,:threshold)
    secrets.first(n).each{pipe.puts _1}
    pipe.read.lines.last.chomp
  end
end
end
end
