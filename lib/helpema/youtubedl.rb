require 'json'

module Helpema
  module YouTubeDL
    extend Piper
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
    def json(url, &blk) = YouTubeDL._json(url:url, &blk)

    YouTubeDL.define_command(:_mp3,
      cmd: 'youtube-dl', version: YouTubeDL.version,
      usage: { output: nil,
               format: true,
               arg0: 'bestaudio',
               'extract-audio': true,
               'audio-format': true,
               arg1: 'mp3',
               'audio-quality': true,
               arg2: 0,
               arg3: nil },
      synonyms: {url: :arg3},
      err: '/dev/null')
    def mp3(url, output:'%(id)s.%(ext)s') = YouTubeDL._mp3(url:url, output:output)

    extend self
  end
end
