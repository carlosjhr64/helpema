Gem::Specification.new do |s|

  s.name     = 'helpema'
  s.version  = '2.0.200124'

  s.homepage = 'https://github.com/carlosjhr64/helpema'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2020-01-24'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
Meant to be an eclectic collection of useful single functions and wrappers.
Wrappers: ssss-split, ssss-combine, zbarcam, youtube-dl -j.
Funtions: requires("gemname version",...).

More later.
DESCRIPTION

  s.summary = <<SUMMARY
Meant to be an eclectic collection of useful single functions and wrappers.
Wrappers: ssss-split, ssss-combine, zbarcam, youtube-dl -j.
Funtions: requires("gemname version",...).
SUMMARY

  s.require_paths = ['lib']
  s.files = %w(
README.md
lib/helpema.rb
lib/helpema/helpema.rb
lib/helpema/ssss.rb
lib/helpema/youtubedl.rb
lib/helpema/zbar.rb
  )

  s.requirements << 'ruby: ruby 2.7.0p0 (2019-12-25 revision 647ee6f091) [x86_64-linux]'
  s.requirements << 'ssss-split: 0.5'
  s.requirements << 'ssss-combine: 0.5'
  s.requirements << 'zbarcam: 0.23'
  s.requirements << 'gnome-screenshot: gnome-screenshot 3.34.0'

end
