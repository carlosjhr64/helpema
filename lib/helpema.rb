module Helpema
  VERSION = '4.0.221210'

  autoload :Piper,     'helpema/piper.rb'
  autoload :Rubish,    'helpema/rubish.rb'
  autoload :SSSS,      'helpema/ssss.rb'
  autoload :YouTubeDL, 'helpema/youtubedl.rb'
  autoload :ZBar,      'helpema/zbar.rb'
  autoload :GPG,       'helpema/gpg.rb'
  autoload :FFMPEG,    'helpema/ffmpeg.rb'

  module Refinements
    refine ::String do
      def satisfies?(*reqs)
        Gem::Requirement.new(*reqs).satisfied_by? Gem::Version.new(self)
      end
    end

    refine ::Kernel do
      def requires(*list)
        loaded = []
        list.each do |gems|
          gems.lines.each do |gemname_reqs|
            gemname, *reqs = gemname_reqs.split
            next unless gemname
            unless reqs.empty?
              case gemname
              when 'helpema'
                unless VERSION.satisfies?(*reqs)
                  raise "helpema #{VERSION} not #{reqs.join(', ')}"
                end
                next
              when 'ruby'
                unless RUBY_VERSION.satisfies?(*reqs)
                  raise "ruby #{RUBY_VERSION} not #{reqs.join(', ')}"
                end
                next
              else
                gem gemname, *reqs
              end
            end
            require gemname and loaded.push gemname
          end
        end
        return loaded
      end
    end
  end

  using Refinements
  def Helpema.requires(*list)
    Kernel.requires(*list)
  end
end

# Requires:
#`ruby`
#`youtube-dl`
#`ssss-split`
#`ssss-combine`
#`zbarcam`
#`zbarimg`
#`scrot`
#`gpg`
