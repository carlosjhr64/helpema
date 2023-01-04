# Helpema

* [VERSION 5.0.221213](https://github.com/carlosjhr64/helpema/releases)
* [github](https://github.com/carlosjhr64/helpema)
* [rubygems](https://rubygems.org/gems/helpema)

## DESCRIPTION:

Meant to be an eclectic collection of useful Linux command wrappers.
Facilitates creation of custom wrappers for any Linux command.

## INSTALL:

```console
$ gem install helpema
```

## SYNOPSIS:

Note that `Helpema` auto-loads assets as requested.
```ruby
require 'helpema'
include Helpema
```
### Helpema::Piper
```ruby
# These will raise RuntimeError unless version matches:
Piper.validate_command('ruby', '^ruby 3.2.0', '--version')
Piper.validate_command('ssss-split', 'Version: 0\.[567]$', '-v')
# Piper.run_command(cmd, options={}, script:nil, usage=nil, synonyms:nil,
#                   mode:'r', exception:nil, forward_pass:nil **popt, &blk)
# Too many features to fully cover in a synopsis...
Piper.run_command('date',{d: 'Dec 31, 2020',I: true}) #=> "2020-12-31\n"
Piper.run_command('bash',script:'echo "Hello"',mode:'w+') #=> "Hello\n"
Piper.run_command('fish',script:'false',mode:'w',exception:false) #=> false
begin
  Piper.run_command('fish',script:'false',mode:'w',exception:'Ooops!')
rescue
  msg = $!.message
end
msg #=> "Ooops!"
```
### Helpema::Piper::Refinements
```ruby
using Piper::Refinements
{d: 'Dec 31, 2020',I: true}.to_args        #=> ["-d", "Dec 31, 2020", "-I"]
{'date=': '2022-12-10', wut: true}.to_args #=> ["--date=2022-12-10", "--wut"]
```
### extend Helpema::Piper
```ruby
### define_command ###
# Create a method out of a system command.
module System
  extend Helpema::Piper
  define_command(:date, cmd: 'date', usage: {d: nil, I: true}, synonyms: {string: :d})
  extend self
end
System.date(string: 'Dec 31, 2020') #=> "2020-12-31\n"
```
### Helpema::Rubish
```ruby
# Predefined Rubish:
Rubish.bash 'echo "Hello!"' #=> "Hello!\n"
Rubish.bash? 'which ruby' #=> true
Rubish.fish? 'false'      #=> false
# Define you own Rubish shell call:
Rubish.shell('ruby', default:'puts RUBY_VERSION')
Rubish.ruby #=> "3.2.0\n"
Rubish.ruby('puts "Hello!"') #=> "Hello!\n"
# And define you own Rubish command call:
Rubish.command('which', usage:{arg0:nil})
def which(cmd) = Rubish.which(arg0:cmd)
which 'echo' # "/usr/bin/echo\n"
```
### Helpema::SSSS.split
```ruby
### SSSS.split ####
SSSS.split(secret: "Top Secret!", threshold: 2, shares: 3)
#~> ^\["1-\h+", "2-\h+", "3-\h+"\]$
# Note that the split has random outputs on the same inputs.
```
### SSS.combine
```ruby
#### SSSS.combine ###
# Pregenerated splits combine to reproduce the secret.
SSSS.combine(secrets: ["3-055562917c41e68c6ab2c8", "1-27bf3cbfe8d2c25c7e8928"],
             threshold: 2)
#=> "Top Secret!"
```
### YouTubeDL.json
```ruby
### YouTubeDL.json ###
list = []
url = 'https://www.youtube.com/watch?v=u4oK3ZSccZI'
Helpema::YouTubeDL.json(url){|json| list.push json}
# The url was for just one video
list.length #=> 1
json = list[0]
json['title'] #=> "Fortnite Easy Last Ten"
```
### YouTubeDL.mp3(url, output: '%(id)s.%(ext)s')
### FFMPEG.hash(filename, digest: 'sha160')
### ZBar.screen
```ruby
### ZBar.screen ###
# Reads qrcodes on screen.
string_or_nil = Helpema::ZBar.screen
```
### ZBar.cam
```ruby
### ZBar.cam ###
# Reads qrcodes from camera.
# You may want to wrap this one in a Timeout block.
#     string = ZBar.cam
```
### GPG.encrypt and GPG.decrypt
```ruby
### GPG Symmetric ###
## String to String
encrypted = Helpema::GPG.encrypt(passphrase: '<Secret>', string: '<Plain Text>')
decrypted = Helpema::GPG.decrypt(passphrase: '<Secret>', string: encrypted)
#=> "<Plain Text>"
## File to File
# Got a text file...
`md5sum tmp/text.txt` #~> ^d27b3111fdeb72f2862909c216214bc1
# gpg wont overwrite, so need to remove existing...
File.exist?(_='tmp/text.enc') and File.unlink(_)
File.exist?(_='tmp/text.dec') and File.unlink(_)
# Encrypt text file...
Helpema::GPG.encrypt(passphrase: '<Secret>', input: 'tmp/text.txt', output: 'tmp/text.enc') #=> ""
# Decrypt encrypted file...
Helpema::GPG.decrypt(passphrase: '<Secret>', input: 'tmp/text.enc', output: 'tmp/text.dec') #=> ""
# Decrypted file should match...
`md5sum tmp/text.dec` #~> ^d27b3111fdeb72f2862909c216214bc1
## IO to IO
require 'stringio'
pio = StringIO.new '<Plain>'
eio = StringIO.new ''
dio = StringIO.new ''
Helpema::GPG.encrypt(passphrase: '<Secret>', ioin: pio, ioout: eio)
eio.rewind
Helpema::GPG.decrypt(passphrase: '<Secret>', ioin: eio, ioout: dio)
dio.string #=> "<Plain>"
```
## TROUBLESHOOTING:

+ Command version mismatch: set `Helpema::WRAPPER.version = "your.version"` or just nil it.

## LICENSE:

(The MIT License)

Copyright (c) 2023 CarlosJHR64

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
