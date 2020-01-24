require 'open3'

module HELPEMA
module SSSS
  # Note how the function mirrors the command line options.
  def self.split(secret, t0=2, n0=3,
                 t: t0, n: n0,
                 threshold: t, shares: n,
                 w: nil, s: nil, x: false,
                 token: w, level: s, hexmode: x)
    pwds = nil
    command = "ssss-split -Q -t #{threshold} -n #{shares}"
    command << " -w #{token}"  if token
    command << " -s #{level}"  if level
    command << " -x"           if hexmode
    Open3.popen3(command) do |stdin, stdout, stderr|
      stdin.puts secret
      stdin.close
      pwds = stdout.read.split("\n")
    end
    return pwds
  end

  def self.combine(*pwds)
    pwd = ''
    Open3.popen3("ssss-combine -q -t #{pwds.length}") do |stdin, stdout, stderr|
      pwds.each{|p| stdin.puts p}
      stdin.close
      pwd = stderr.read.split("\n").last
    end
    return pwd
  end
end
end
