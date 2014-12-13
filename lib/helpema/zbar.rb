module Helpema
module ZBar

  def self.qrcode(timeout=3)
    qrcode = nil
    IO.popen('zbarcam --nodisplay --raw --prescale=800x800', 'r') do |io|
      begin
        Timeout.timeout(timeout) do
          qrcode = io.gets.strip
        end
      rescue Timeout::Error
        $stderr.puts $!
      ensure
        Process.kill('INT', io.pid)
      end
    end
    qrcode
  end

end
end
