module Helpema
  module Rubish
    extend Piper
    def Rubish.shell(name,
                     cmd:name.to_s.chomp('?').chomp('!'),
                     version:nil, v:nil,
                     usage:nil,   synonyms:nil,
                     default:nil)
      mode,exception = (name[-1]=='?')? ['w',false] : ['w+',nil]
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
                      usage:nil,   synonyms:nil)
      mode = 'r'
      exception = (name[-1]=='?')? false : nil
      Rubish.define_command(name.to_sym,
                            cmd:cmd,
                            version:version, v:v,
                            usage:usage,     synonyms:synonyms,
                            mode:mode,       exception:exception)
    end
    extend self
  end
end
