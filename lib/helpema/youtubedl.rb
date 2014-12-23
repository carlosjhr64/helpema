module Helpema
module YouTubeDL

  def self.json(url, pwd=nil)
    Open3.popen2e("youtube-dl -j '#{url}'") do |i, o|
      i.puts pwd if pwd
      i.close
      o.each do |line|
        begin
          yield JSON.parse line
        rescue JSON::ParserError
          yield line
        end
      end
    end
  end

end
end
