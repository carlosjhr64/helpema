module Helpema
module ZBar

  def self.qrcode(timeout=3)
    qrcode = ''
    IO.popen('zbarcam --nodisplay --raw --prescale=800x800', 'r') do |io|
      begin
        Timeout.timeout(timeout) do
          qrcode << io.gets
          while q = io.gets
            break if q=="\n"
            qrcode << q
          end
          qrcode.strip!
        end
      rescue Timeout::Error
        qrcode = nil
        $stderr.puts $!
      ensure
        Process.kill('INT', io.pid)
      end
    end
    qrcode
  end

end
end
