#!/usr/bin/env ruby

require "optparse"
require "securerandom"
require "pathname"

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


words = IO.readlines(Pathname(__dir__).join("words.txt")).map(&:chomp)
combinations = words.count ** length
puts "Choosing passphrases with #{length} words from #{words.count} word dictionary"
puts "Each passphrase should have #{Math::log2(combinations).floor} bits of entropy,"
puts "which is stronger than a #{Math::log(combinations, 96).floor} character random pass"

count.times do
  puts length.times.collect { words[SecureRandom.random_number(words.count)] }.join("").downcase
end
