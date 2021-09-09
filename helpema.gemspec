Gem::Specification.new do |s|

  s.name     = 'helpema'
  s.version  = '3.1.210909'

  s.homepage = 'https://github.com/carlosjhr64/helpema'

  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2021-09-09'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
Meant to be an eclectic collection of useful single functions and wrappers.

Featured method: `requires "good ~>3.0", "bad ~>2.7", "ugly ~>1.8"`
DESCRIPTION

  s.summary = <<SUMMARY
Meant to be an eclectic collection of useful single functions and wrappers.
SUMMARY

  s.require_paths = ['lib']
  s.files = %w(
README.md
lib/helpema.rb
lib/helpema/gpg.rb
lib/helpema/helpema.rb
lib/helpema/ssss.rb
lib/helpema/youtubedl.rb
lib/helpema/zbar.rb
  )

  s.requirements << 'ruby: ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-linux]'
  s.requirements << 'youtube-dl: 2021.06.06'
  s.requirements << 'ssss-split: 0.5'
  s.requirements << 'ssss-combine: 0.5'
  s.requirements << 'zbarcam: 0.23'
  s.requirements << 'zbarimg: 0.23'
  s.requirements << 'gnome-screenshot: gnome-screenshot 40.0'
  s.requirements << 'gpg: gpg (GnuPG) 2.2.27'

end
