Gem::Specification.new do |s|

  s.name     = 'helpema'
  s.version  = '3.0.210103'

  s.homepage = 'https://github.com/carlosjhr64/helpema'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2021-01-03'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
Meant to be an eclectic collection of useful single functions and wrappers.

Functions:

* requires
* to_opt
* run_command
* define_command

Refinements:

* Array#classify
* String#satisfies?
* Symbol#to_opt

Wrappers:

* ssss-split
* ssss-combine
* zbarcam
* zbarimg
* youtube-dl

DESCRIPTION

  s.summary = <<SUMMARY
Meant to be an eclectic collection of useful single functions and wrappers.
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

  s.requirements << 'ruby: ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]'
  s.requirements << 'youtube-dl: 2020.12.29'
  s.requirements << 'ssss-split: 0.5'
  s.requirements << 'ssss-combine: 0.5'
  s.requirements << 'zbarcam: 0.23'
  s.requirements << 'zbarimg: 0.23'
  s.requirements << 'gnome-screenshot: gnome-screenshot 3.38.0'

end
