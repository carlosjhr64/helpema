module HELPEMA
module Helpema
  def requires(*list)
    loaded = []
    list.each do |gems|
      gems.lines.each do |gemname_version|
        gemname, *version = gemname_version.split
        gem gemname, *version  unless version.empty?
        require gemname and loaded.push gemname
      end
    end
    loaded
  end
  extend self
end
end
