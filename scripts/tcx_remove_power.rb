#!/usr/bin/env ruby

require "nokogiri"

path = ARGV.first
xml = File.open(path) { |f| Nokogiri::XML(f) }
namespace = { "TPX" => "http://www.garmin.com/xmlschemas/ActivityExtension/v2" }
watts =  xml.xpath("//TPX:Watts", namespace)
watts.remove
target = "#{File.dirname(path)}/#{File.basename(path, ".tcx")}_no_power.tcx"
File.open(target, "w") { |f| f.puts(xml) }

