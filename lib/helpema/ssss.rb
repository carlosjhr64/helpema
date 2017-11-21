require 'open3'

module Helpema
module SSSS

  def self.split(pwd, t, n)
    pwds = nil
    Open3.popen3("ssss-split -Q -t #{t} -n #{n}") do |stdin, stdout, stderr|
      stdin.puts pwd
      stdin.close
      pwds = stdout.read.strip.split
    end
    return pwds
  end

  def self.combine(*pwds)
    pwd = ''
    Open3.popen3("ssss-combine -Q -t #{pwds.length}") do |stdin, stdout, stderr|
      pwds.each{|p| stdin.puts p}
      stdin.close
      pwd = stderr.read.strip.split.last
    end
    return pwd
  end

end
end
