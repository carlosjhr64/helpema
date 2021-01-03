module Helpema
  VERSION = '3.0.210103'

  require_relative     'helpema/helpema'

  autoload :SSSS,      'helpema/ssss.rb'
  autoload :YouTubeDL, 'helpema/youtubedl.rb'
  autoload :ZBar,      'helpema/zbar.rb'
end

# Requires:
#`ruby`
#`youtube-dl`
#`ssss-split`
#`ssss-combine`
#`zbarcam`
#`zbarimg`
#`gnome-screenshot`
