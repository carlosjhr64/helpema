# helpema

* [VERSION 3.0.210103](https://github.com/carlosjhr64/helpema/releases)
* [github](https://github/carlosjhr64/helpema)
* [rubygems](https://rubygems/gems/helpema)

## DESCRIPTION:

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

## SYNOPSIS:

```ruby
require 'helpema'
include Helpema

### requires ###
# Ensure ruby's and helpema's version.
# Returns the list of loaded gems.
# For those quick little scripts one writes in one's bin
# that annoyingly keep falling out of maintainance... right?
requires'
ruby          ~>3.0
helpema       ~>3.0
base_convert  ~>4.0
entropia      ~>0.1'
#=> ["base_convert", "entropia"]

### to_opt ###
# A helper function to do system command calls.
to_opt :q, true             #=> "-q"
to_opt :quiet, true         #=> "--quiet"
to_opt :verbose, false      #=> nil
to_opt :f, '/path-to/file'  #=> ["-f", "/path-to/file"]
to_opt :geo=, '10x20'       #=> "--geo=10x20"
to_opt :arg0, 'Hello World' #=> "Hello World"

### run_command ###
# Automates pipe creation to a system command.
# See the code for all available features.
run_command('date',{d: 'Dec 31, 2020'}) #=> "Thu Dec 31 12:00:00 AM PST 2020\n"

### define_command ###
# Creates a method out of a system command.
# See the code for all available features.
define_command(:date, cmd: 'date')
date(d: 'Dec 31, 2020') #=> "Thu Dec 31 12:00:00 AM PST 2020\n"

using Helpema # for refinements

### Symbol#to_opt ###
:a.to_opt    #=> "-a"
:abc.to_opt  #=> "--abc"
:arg0.to_opt #=> nil

### String#satisfies? ###
# Uses Gem::Requirement and Gem::Version to check version strings.
'1.2.3'.satisfies? '~>1.1' #=> true
'1.2.3'.satisfies? '~>1.3' #=> false

### Array#classify ###
# Groups items in Array by class.
[1, 2.0, :Three, 'Four', /Five/, :Six, 'Seven'].classify
#=> {Integer=>[1], Float=>[2.0], Symbol=>[:Three, :Six], String=>["Four", "Seven"], Regexp=>[/Five/]}

### SSSS.split ####
SSSS.split(secret: "Top Secret!", threshold: 2, shares: 3)
#~> ^\["1-\h+", "2-\h+", "3-\h+"\]$
# Note that the split has random outputs on the same inputs.

#### SSSS.combine ###
# Pregenerated splits combine to reproduce the secret.
SSSS.combine(secrets: ["3-055562917c41e68c6ab2c8", "1-27bf3cbfe8d2c25c7e8928"], threshold: 2)
#=> "Top Secret!"

### YouTubeDL.json ###
list = []
url = 'https://www.youtube.com/watch?v=u4oK3ZSccZI'
YouTubeDL.json(url: url){|json| list.push json}
# The url was for just one video
list.length #=> 1
json = list[0]
json['title'] #=> "Fortnite Easy Last Ten"

### ZBar.screen ###
# Reads qrcodes on screen.
string_or_nil = ZBar.screen

### ZBar.cam ###
# Reads qrcodes from camera.
# You may want to wrap this one in a Timeout block.
string = ZBar.cam
```

## INSTALL:

```shell
$ gem install helpema
```

## FEATURES:

* Autoloaded: no need to pick and choose which library component to require.

## LICENSE:

(The MIT License)

Copyright (c) 2021 carlosjhr64

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
