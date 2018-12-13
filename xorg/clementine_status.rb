#!/usr/bin/env ruby

raw_data = `qdbus org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata`
data = raw_data
  .split("\n")
  .map{ |line| line.split(": ") }
  .to_h

puts "♫ #{data['xesam:artist']} - #{data['xesam:album']} - #{data['xesam:trackNumber']} #{data['xesam:title']} ♫"
