module Helpema
  module GPG
    extend Helpema
    class << self; attr_accessor :version; end
    GPG.version = '^gpg \\(GnuPG\\) 2\.[234]\.' # version as of this writing is 2.2.27

    GPG.define_command(:cryptor,
      cmd: 'gpg', version: GPG.version,
      usage: {
        quiet: true,
        batch: true,
        'passphrase-fd': 0,
        output: nil,
        symmetric: nil,
        decrypt: nil,
        arg0: nil,
      },
      synonyms: {
        input: :arg0,
      },
      mode: 'w+',
      exception: 'gpg failed'
    ) do |pipe, options, blk|
      passphrase, string, ioin, ioout =
        options.fetch_values(:passphrase, :string, :ioin, :ioout)
      pipe.puts passphrase
      Thread.new do
        if string
          pipe.write string
        elsif ioin
          while c = ioin.getbyte
            pipe.putc c
          end
        end
        pipe.close_write
      end
      if ioout
        while c = pipe.getbyte
          ioout.putc c
        end
      else
        pipe.read
      end
    end

    def encrypt(passphrase:,
                string:nil,
                output:nil,
                input:nil,
                ioin:nil,
                ioout:nil)
      unless [string,input,ioin].count{_1} == 1
        raise "Need only one of string, input, or ioin"
      end
      raise "Can't have both output and ioout" if output and ioout
      GPG.cryptor(symmetric:  true,
                  passphrase: passphrase,
                  string:     string,
                  input:      input,
                  output:     output,
                  ioin:       ioin,
                  ioout:      ioout)
    end

    def decrypt(passphrase:,
                string:nil,
                output:nil,
                input:nil,
                ioin:nil,
                ioout:nil)
      unless [string,input,ioin].count{_1} == 1
       raise "Need only one of string, input, or ioin"
      end
      raise "Can't have both output and ioout" if output and ioout
      GPG.cryptor(decrypt:    true,
                  passphrase: passphrase,
                  string:     string,
                  input:      input,
                  output:     output,
                  ioin:       ioin,
                  ioout:      ioout)
    end

    extend self
  end
end
