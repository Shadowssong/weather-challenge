$: << './lib'
require 'weather'

weather = Weather.new('bin/weather.dat')
weather.process_file

puts "Smallest spread found was on day #{weather.smallest_spread[:day]} with a spread of #{weather.smallest_spread[:value]}"
