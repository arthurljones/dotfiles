#!/usr/bin/env ruby

require "nokogiri"

path = ARGV.first
xml = File.open(path) { |f| Nokogiri::XML(f) }
namespace = { "TrainingCenterDatabase" => "http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2" }
targets = []
hr = xml.css('HeartRateBpm Value').each do |node|
  targets << node.parent if node.content == "0"
end
puts "Removing #{targets.size} HR samples of '0'"
targets.each(&:remove)
puts xml
target = "#{File.dirname(path)}/#{File.basename(path, ".tcx")}_no_hr_zeroes.tcx"
File.open(target, "w") { |f| f.puts(xml) }

