require 'open-uri'
require 'pp'

  results = []

  #url = URI.parse ('http://bostonlocaltv.org')

  open ('http://bostonlocaltv.org') do |f|
     f.each_line {|line| results << line}
  end

 i = 0
 results.each do |line|
     i = i + 1
     puts "line #: " + i
     puts results
 end

