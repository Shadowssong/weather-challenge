require 'spec_helper'

describe weather_parserParser do
  let(:weather_parser) { weather_parserParser.new('./bin/weather_parser.dat') }

  describe '#contain_column_names?' do
    let(:parsed_line) { ["Dy", "MxT", "MnT"] }
    let(:bad_parsed_line) { ["Dy", "TxT", "MnT"] }

    it 'returns true if parsed line contains column names' do
      weather_parser.contain_column_names?(parsed_line).should be_true
    end

    it 'returns false if parsed line does not contain column names' do
      weather_parser.contain_column_names?(bad_parsed_line).should be_false
    end
  end

  describe '#calculate_spread' do
    let(:parsed_line) { ["1", "88", "59*"] }

    it 'properly calculates the spread' do
      weather_parser.calculate_spread(parsed_line).should eq(29)
    end
  end

  describe '#init spread' do
    let(:spread)  { 5 }
    let(:day)     { 1 }
    let(:smallest_spread) { { value: 1, day: 1 } }
    let(:updated_smallest_spread) { { value: 5, day: 1 } }

    it 'initializes the spread hash' do
      weather_parser.init_spread(spread, day)
      weather_parser.smallest_spread.should eq(updated_smallest_spread)
      weather_parser.spread_set.should be_true
    end
  end

  describe '#compare_spreads' do
    let(:spread)  { 5 }
    let(:day)     { 1 }
    let(:goal_spread) { { value: 5, day: 1 } }
    let(:smaller_spread) { { value: 2, day: 1 } }

    it 'updates hash if spread is smaller' do
      weather_parser.init_spread(7, 1)
      weather_parser.compare_spreads(spread, day)
      weather_parser.smallest_spread.should eq(goal_spread)
    end

    it 'does not update the hash if spread is not smaller' do
      weather_parser.init_spread(2, 1)
      weather_parser.compare_spreads(spread, day)
      weather_parser.smallest_spread.should eq(smaller_spread)
    end
  end

  describe '#process_file' do
    let(:smallest_spread) { { value: 2, day: 14 } }

    it 'scans the file and returns the correct smallest spread' do
      weather_parser.process_file
      weather_parser.smallest_spread.should eq(smallest_spread)
    end
  end
end
