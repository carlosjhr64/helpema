module Helpema
  VERSION = '4.0.221208'

  require_relative     'helpema/helpema'

  autoload :SSSS,      'helpema/ssss.rb'
  autoload :YouTubeDL, 'helpema/youtubedl.rb'
  autoload :ZBar,      'helpema/zbar.rb'
  autoload :GPG,       'helpema/gpg.rb'
  autoload :FFMPEG,    'helpema/ffmpeg.rb'
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
