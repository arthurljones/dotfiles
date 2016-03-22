#!/usr/bin/ruby

require "optparse"
require "securerandom"

count = 4
length = 4

OptionParser.new do |opts|
  opts.banner = "Usage: update_zones.rb [options] <zone_file> ..."

  opts.on("-l", "--length NUM", OptionParser::DecimalInteger, "Generate passwords NUM words long (default #{length}") do |v|
    length = v
  end

  opts.on("-c", "--count NUM", OptionParser::DecimalInteger, "Generate NUM passwords (default #{count}") do |v|
    count = v
  end

end.parse!

words = File.read("/usr/share/dict/words").split("\n")
count.times do
  puts length.times.collect { words[SecureRandom.random_number(words.count)] }.join("").downcase
end
