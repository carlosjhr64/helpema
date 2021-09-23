module Helpema
  module FFMPEG
    extend Helpema

    FFMPEG.define_command(:_hash,
      cmd: 'ffmpeg',
      usage: {arg0: '-i',
              arg1: nil,
              arg2: '-f',
              arg3: 'hash',
              arg4: '-hash',
              arg5: nil,
              arg6: '-'},
      synonyms: {filename: :arg1, digest: :arg5},
      exception: 'ffmpeg failed',
      err: '/dev/null')
    def hash(filename, digest:'sha160')
      FFMPEG._hash(filename:filename, digest:digest).split('=').last
    end

    extend self
  end
end
