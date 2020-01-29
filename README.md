# helpema

* [VERSION 2.0.200124](https://github.com/carlosjhr64/helpema/releases)
* [github](https://github/carlosjhr64/helpema)
* [rubygems](https://rubygems/gems/helpema)

## DESCRIPTION:

Meant to be an eclectic collection of useful single functions and wrappers.
Wrappers: ssss-split, ssss-combine, zbarcam, youtube-dl -j.
Functions: requires("gemname version",...).

More later.

## SYNOPSIS:

    require 'helpema'
    include HELPEMA

    Helpema.requires <<-GEMS
      awesome_print ~>1.8
      base_convert ~>4.0
      entropia ~>0.1
    GEMS
    #=> ["awesome_print", "base_convert", "entropia"]
    # Returns the list of loaded gems.
    # For those quick little scripts one writes in one's bin
    # that annoyingly keep falling out of maintainance... right?

    SSSS.split("Top Secret!", threshold: 2, shares: 3)
    #~> ^\["1-\h+", "2-\h+", "3-\h+"\]$
    # Note that the split has random outputs on the same inputs.

    SSSS.combine("3-055562917c41e68c6ab2c8", "1-27bf3cbfe8d2c25c7e8928")
    #=> Top Secret!
    # Pregenerated splits combine to reproduce the secret.

    list = []
    url = 'https://www.youtube.com/watch?v=u4oK3ZSccZI'
    YouTubeDL.json(url){|json| list.push json}
    # The url was for just one video
    list.length #=> 1
    json = list[0]
    json['title'] #=> "Fortnite Easy Last Ten"

    ZBar.cam( timeout=3 ) # Reads qrcodes on camera.
    ZBar.screen # Reads qrcodes on screen.

## INSTALL:

    $ sudo gem install helpema

## FEATURES:

* Autoloaded: no need to pick and choose which library component to require.

## LICENSE:

(The MIT License)

Copyright (c) 2020 carlosjhr64

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
