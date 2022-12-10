module Helpema
  module Rubish
    extend Piper
    def Rubish.shell(name,
                     cmd:name.to_s.chomp('?').chomp('!'),
                     version:nil,    v:nil,
                     usage:nil,      synonyms:nil,
                     exception:nil,  default:nil)
      if name[-1]=='?'
        mode = 'w'
        exception = false unless exception
      else
        mode = 'w+'
      end
      Rubish.define_command(name.to_sym,
                            cmd:cmd,
                            version:version, v:v,
                            usage:usage,     synonyms:synonyms,
                            mode:mode,       exception:exception,
                            default:default) # default script
    end
    Rubish.shell :fish
    Rubish.shell :fish?
    Rubish.shell :bash
    Rubish.shell :bash?
    def Rubish.command(name,
                      cmd:name.to_s.chomp('?').chomp('!'),
                      version:nil, v:nil,
                      usage:nil,   synonyms:nil, exception:nil)
      mode = 'r'
      exception = false if name[-1]=='?' and not exception
      Rubish.define_command(name.to_sym,
                            cmd:cmd,
                            version:version, v:v,
                            usage:usage,     synonyms:synonyms,
                            mode:mode,       exception:exception)
    end
    extend self
  end
end
