Gem::Specification.new do |s|

  s.name     = 'helpema'
  s.version  = '5.0.221213'

  s.homepage = 'https://github.com/carlosjhr64/helpema'

  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2022-12-13'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
Meant to be an eclectic collection of useful Linux command wrappers.
Facilitates creation of custom wrappers for any Linux command.
DESCRIPTION

  s.summary = <<SUMMARY
Meant to be an eclectic collection of useful Linux command wrappers.
Facilitates creation of custom wrappers for any Linux command.
SUMMARY

  s.require_paths = ['lib']
  s.files = %w(
README.md
lib/helpema.rb
lib/helpema/ffmpeg.rb
lib/helpema/gpg.rb
lib/helpema/piper.rb
lib/helpema/rubish.rb
lib/helpema/ssss.rb
lib/helpema/youtubedl.rb
lib/helpema/zbar.rb
  )

  s.requirements << 'ruby: ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [aarch64-linux]'
  s.requirements << 'youtube-dl: 2021.12.17'
  s.requirements << 'ssss-split: 0.5'
  s.requirements << 'ssss-combine: 0.5'
  s.requirements << 'zbarcam: 0.23.90'
  s.requirements << 'zbarimg: 0.23.90'
  s.requirements << 'scrot: scrot version 1.5'
  s.requirements << 'gpg: gpg (GnuPG) 2.2.27'

end
