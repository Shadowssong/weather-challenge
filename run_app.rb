$: << './lib'
require 'weather'

smallest_spread = Weather.process_file('bin/weather.dat')

puts "Smallest spread found was on day #{smallest_spread[:day]} with a spread of #{smallest_spread[:value]}"
