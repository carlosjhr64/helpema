require 'json'

module Helpema
  module YouTubeDL
    extend Helpema
    class << self; attr_accessor :version; end
    YouTubeDL.version = '^202\d\.[01]\d\.[0123]\d$'

    YouTubeDL.define_command(:_json,
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
    def json(url, &blk) = _json(url:url, &blk)

    extend self
  end
end
