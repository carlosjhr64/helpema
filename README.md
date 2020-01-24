# helpema

* [VERSION 1.1.200123](https://github.com/carlosjhr64/helpema/releases)
* [github](https://github/carlosjhr64/helpema)
* [rubygems](https://rubygems/gems/helpema)

## DESCRIPTION:

Some wrappers on the following linux commands: ssss-split, ssss-combine, zbarcam, youtube-dl -j.

More later.

## SYNOPSIS:

    require 'helpema'
    include Helpema
    SSSS.split( secret, threshold, shares)
    SSSS.combine( *shared_secrets )
    ZBar.cam( timeout=3 ) # Reads qrcodes on camera.
    ZBar.screen # Reads qrcodes on screen.
    YouTubeDL.json( url ){|obj| obj.inspect }

## INSTALL:

    $ sudo gem install helpema

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
