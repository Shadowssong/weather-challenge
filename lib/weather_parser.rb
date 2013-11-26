class WeatherParser
  def initialize(file_path)
    @file_path = file_path
    @reading_in_values = false
    @spread_set        = false
    @smallest_spread   = {value: 0, day: 0}
  end

  def smallest_spread
    @smallest_spread
  end

  def spread_set
    @spread_set
  end

  def contain_column_names?(parsed_line)
    parsed_line[0].include?("Dy") && parsed_line[1].include?("MxT") && parsed_line[2].include?("MnT")
  end

  def calculate_spread(parsed_line)
    max_temp = parsed_line[1].delete("*").to_i
    min_temp = parsed_line[2].delete("*").to_i
    max_temp - min_temp
  end

  def init_spread(spread, day)
    @smallest_spread[:value] = spread
    @smallest_spread[:day] = day
    @spread_set = true
  end

  def compare_spreads(spread, day)
    if spread < @smallest_spread[:value]
      @smallest_spread[:value] = spread
      @smallest_spread[:day] = day
    end
  end

  def process_file
    # quick sanity check for file passed in
    exit unless File.exists?(@file_path)

    File.readlines(@file_path).each do |line|
      parsed_line = line.split(" ")
      # first we look for the line which tells us the next lines will be the values we want
      if parsed_line.count >= 2 && !@reading_in_values
        @reading_in_values = contain_column_names?(parsed_line)
      elsif @reading_in_values
        # if line is empty lets skip to the next
        next if parsed_line[0].nil?
        # check if we have reached the end of temp values
        break if parsed_line[0].include?("mo")
        # calculate spread
        day = parsed_line[0].to_i
        spread = calculate_spread(parsed_line)
        # if spread hasn't been set lets init it to the first value we find
        init_spread(spread, day) unless @spread_set
        # check if spread is new smallest value
        compare_spreads(spread, day)
      end
    end
    @smallest_spread
  end
end
