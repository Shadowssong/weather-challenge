require 'spec_helper'

describe Weather do
  let(:weather) { Weather.new('./bin/weather.dat') }

  describe '#contain_column_names?' do
    let(:parsed_line) { ["Dy", "MxT", "MnT"] }
    let(:bad_parsed_line) { ["Dy", "TxT", "MnT"] }

    it 'returns true if parsed line contains column names' do
      weather.contain_column_names?(parsed_line).should be_true
    end

    it 'returns false if parsed line does not contain column names' do
      weather.contain_column_names?(bad_parsed_line).should be_false
    end
  end

  describe '#calculate_spread' do
    let(:parsed_line) { ["1", "88", "59*"] }

    it 'properly calculates the spread' do
      weather.calculate_spread(parsed_line).should eq(29)
    end
  end

  describe '#init spread' do
    let(:spread)  { 5 }
    let(:day)     { 1 }
    let(:smallest_spread) { { value: 1, day: 1 } }
    let(:updated_smallest_spread) { { value: 5, day: 1 } }

    it 'initializes the spread hash' do
      weather.init_spread(spread, day)
      weather.smallest_spread.should eq(updated_smallest_spread)
      weather.spread_set.should be_true
    end
  end

  describe '#compare_spreads' do
    let(:spread)  { 5 }
    let(:day)     { 1 }
    let(:goal_spread) { { value: 5, day: 1 } }
    let(:smaller_spread) { { value: 2, day: 1 } }

    it 'updates hash if spread is smaller' do
      weather.init_spread(7, 1)
      weather.compare_spreads(spread, day)
      weather.smallest_spread.should eq(goal_spread)
    end

    it 'does not update the hash if spread is not smaller' do
      weather.init_spread(2, 1)
      weather.compare_spreads(spread, day)
      weather.smallest_spread.should eq(smaller_spread)
    end
  end

  describe '#process_file' do
    let(:smallest_spread) { { value: 2, day: 14 } }

    it 'scans the file and returns the correct smallest spread' do
      weather.process_file
      weather.smallest_spread.should eq(smallest_spread)
    end
  end
end
