require 'tmpdir'

module Helpema
  module ZBar
    extend Helpema
    class << self; attr_accessor :version, :screenshot; end
    ZBar.version = '^0\.2[345]\b' # version as of this writing is 0.23
    ZBar.screenshot = ['scrot']

    def snapshot(filename)
      system(*ZBar.screenshot, filename)
    end

    ZBar.define_command(:_cam,
                        cmd: 'zbarcam',
                        version: ZBar.version,
                        usage: {raw:true,quiet:true,nodisplay:true, :prescale= => '800x800'},
                        synonyms: {prescale: :prescale=}
    ) do |pipe, kw, blk|
      begin
        pipe.gets.chomp # This is the return value!
      ensure
        Process.kill('TERM', pipe.pid)
      end
    end
    def cam() = ZBar._cam()

    ZBar.define_command(:_img,
                        cmd: 'zbarimg',
                        version: ZBar.version,
                        usage: {q:true,raw:true,arg0:nil},
                        synonyms: {filename: :arg0})
    def img(filename) = ZBar._img(filename:filename)

    def screen
      raw = nil
      Dir.mktmpdir do |tmpdir|
       _ = File.join(tmpdir, "#{$$}.#{Time.now.to_f}.png")
       raw = _ if ZBar.snapshot(_) and not (_=ZBar.img(_).chomp).empty?
      end
      raw
    end

    extend self
  end
end
