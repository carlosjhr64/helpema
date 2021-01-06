require 'tmpdir'

module Helpema
module ZBar
class << self
  attr_accessor :version, :screenshot
  ZBar.version = '^0\.2[345]$' # version as of this writing is 0.23
  ZBar.screenshot = ['gnome-screenshot', '-f']

  def cam() = _cam()
  define_command(:_cam,
    cmd: 'zbarcam', version: ZBar.version,
    usage: {raw:true,quiet:true,nodisplay:true, :prescale= => '800x800'},
    synonyms: {prescale: :prescale=}
  ) do |pipe, kw, blk|
    begin
      pipe.gets.chomp # This is the return value!
    ensure
      Process.kill('TERM', pipe.pid)
    end
  end

  def img(filename) = _img(filename:filename)
  define_command(:_img, cmd: 'zbarimg', version: ZBar.version,
                 usage: {q:true,raw:true,arg0:nil}, synonyms: {filename: :arg0})

  def screen
    raw = nil
    Dir.mktmpdir do |tmpdir|
     _ = File.join(tmpdir, "#{$$}.#{Time.now.to_f}.png")
     raw = _ if snapshot(_) and not (_=ZBar.img(_).chomp).empty?
    end
    raw
  end

  private
  def snapshot(filename)
    system(*ZBar.screenshot, filename)
  end
end
end
end
