require 'json'

module Helpema
module YouTubeDL
class << self
  attr_accessor :version
  YouTubeDL.version = '^202\d\.[01]\d\.[0123]\d$'

  def json(url, &blk) = _json(url:url, &blk)
  define_command(:_json,
    cmd: 'youtube-dl', version: YouTubeDL.version,
    usage: {j:true, arg0:nil}, synonyms: {url: :arg0},
    err: '/dev/null'
  ) do |pipe, options, blk|
    pipe.each do |data|
      begin
        data = JSON.parse data
      ensure
        blk.call data
      end
    end
  end
end
end
end
