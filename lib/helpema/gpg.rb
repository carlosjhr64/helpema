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
      mode: 'w+'
    ) do |pipe, options, blk|
      passphrase, string = options.fetch_values(:passphrase, :string)
      pipe.puts passphrase
      pipe.write string if string
      pipe.close_write
      pipe.read
    end

    def encrypt(passphrase:, string:nil, output:nil, input:nil)
      if (string and input) or (!string and !input)
        raise "Need string xor input(filename)"
      end
      GPG.cryptor(symmetric:  true,
                  passphrase: passphrase,
                  string:     string,
                  input:      input,
                  output:     output)
    end

    def decrypt(passphrase:, string:nil, output:nil, input:nil)
      if (string and input) or (!string and !input)
        raise "Need string xor input(filename)"
      end
      GPG.cryptor(decrypt:    true,
                  passphrase: passphrase,
                  string:     string,
                  input:      input,
                  output:     output)
    end

    extend self
  end
end
