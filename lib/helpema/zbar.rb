require 'timeout'
require 'tmpdir'

module Helpema
module ZBar

  def self.cam(timeout=3)
    raw = ''
    IO.popen('zbarcam --nodisplay --raw --prescale=800x800', 'r') do |io|
      begin
        Timeout.timeout(timeout) do
          raw << io.gets
          while q = io.gets
            break if q=="\n"
            raw << q
          end
          raw.strip!
        end
      rescue Timeout::Error
        raw = nil
        $stderr.puts $!
      ensure
        Process.kill('INT', io.pid)
      end
    end
    raw
  end

  def self.screen
    raw = nil
    Dir.mktmpdir do |tmpdir|
      screenshot = File.join(tmpdir, "#{$$}.#{Time.now.to_f}.png")
      system "gnome-screenshot -f #{screenshot}"
      raw = `zbarimg -q --raw #{screenshot}`.strip
    end
    raw
  end

end
end
