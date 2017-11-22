Gem::Specification.new do |s|

  s.name     = 'helpema'
  s.version  = '1.0.1'

  s.homepage = 'https://github.com/carlosjhr64/helpema'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2017-11-21'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
Some wrappers on the following linux commands: ssss-split, ssss-combine, zbarcam, youtube-dl -j.

More later.
DESCRIPTION

  s.summary = <<SUMMARY
Some wrappers on the following linux commands: ssss-split, ssss-combine, zbarcam, youtube-dl -j.
SUMMARY

  s.extra_rdoc_files = ['README.rdoc']
  s.rdoc_options     = ['--main', 'README.rdoc']

  s.require_paths = ['lib']
  s.files = %w(
README.rdoc
lib/helpema.rb
lib/helpema/ssss.rb
lib/helpema/youtubedl.rb
lib/helpema/zbar.rb
  )

  s.requirements << 'ruby: ruby 2.4.2p198 (2017-09-14 revision 59899) [x86_64-linux]'
  s.requirements << 'ssss-split: 0.5'
  s.requirements << 'ssss-combine: 0.5'
  s.requirements << 'zbarcam: 0.20'
  s.requirements << 'gnome-screenshot: gnome-screenshot 3.22.0'

end
