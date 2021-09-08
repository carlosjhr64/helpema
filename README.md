# Helpema

* [VERSION 3.1.210908](https://github.com/carlosjhr64/helpema/releases)
* [github](https://github.com/carlosjhr64/helpema)
* [rubygems](https://rubygems.org/gems/helpema)

## DESCRIPTION:

Meant to be an eclectic collection of useful single functions and wrappers.

Featured method: `requires "good ~>3.0", "bad ~>2.7", "ugly ~>1.8"`

## INSTALL:

```shell
$ gem install helpema
```

## SYNOPSIS:

```ruby
require 'helpema'
include Helpema
using Helpema

### requires ###
# Ensure ruby's and helpema's version.
# Returns the list of loaded gems.
# For those quick little scripts one writes in one's bin
# that annoyingly keep falling out of maintainance... right?
requires'
ruby          ~>3.0
helpema       ~>3.1
base_convert  ~>4.0
entropia      ~>0.1'
#=> ["base_convert", "entropia"]

### String#satisfies? ###
# Uses Gem::Requirement and Gem::Version to check version strings.
'1.2.3'.satisfies? '~>1.1' #=> true
'1.2.3'.satisfies? '~>1.3' #=> false

### run_command ###
# Automates pipe creation to a system command.
# See the code for all available features.
run_command('date',{d: 'Dec 31, 2020'}) #=> "Thu Dec 31 12:00:00 AM PST 2020\n"

### define_command ###
# Creates a method out of a system command.
# See the code for all available features.
define_command(:date, cmd: 'date', usage: {d: nil}, synonyms: {string: :d})
date(string: 'Dec 31, 2020') #=> "Thu Dec 31 12:00:00 AM PST 2020\n"

### to_arg ###
# A helper function to do system command calls.
to_arg :q, true             #=> "-q"
to_arg :quiet, true         #=> "--quiet"
to_arg :verbose, false      #=> nil
to_arg :f, '/path-to/file'  #=> ["-f", "/path-to/file"]
to_arg :geo=, '10x20'       #=> "--geo=10x20"
to_arg :arg0, 'Hello World' #=> "Hello World"

### Hash#to_args ###
{q: true, quiet: true, verbose: false, f: '/path-to/file', :geo= => '10x20', arg0: 'Hello World'}.to_args
#=> ["-q", "--quiet", "-f", "/path-to/file", "--geo=10x20", "Hello World"]

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
YouTubeDL.json(url){|json| list.push json}
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

## TROUBLESHOOTING:

Command version mismatch
: set `Helpema::WRAPPER.version = "your.version"` or just nil it.

More documentation
: see [sig/helpema.rb](sig/helpema.rbs) for the expected method signatures.

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
