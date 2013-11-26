$: << './lib'
require 'weather'

weather = Weather.new('bin/weather.dat')
weather.process_file
smallest_spread = weather.get_smallest_spread

puts "Smallest spread found was on day #{smallest_spread[:day]} with a spread of #{smallest_spread[:value]}"
