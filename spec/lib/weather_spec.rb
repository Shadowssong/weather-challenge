require 'spec_helper'

describe Weather do
  describe '#contain_column_names?' do
    let(:parsed_line) { ["Dy", "MxT", "MnT"] }
    let(:bad_parsed_line) { ["Dy", "TxT", "MnT"] }

    it 'returns true if parsed line contains column names' do
      Weather.contain_column_names?(parsed_line).should be_true
    end

    it 'returns false if parsed line does not contain column names' do
      Weather.contain_column_names?(bad_parsed_line).should be_false
    end
  end

  describe '#calculate_spread' do
    let(:parsed_line) { ["1", "88", "59*"] }

    it 'properly calculates the spread' do
      Weather.calculate_spread(parsed_line).should eq(29)
    end
  end

  describe '#init spread' do
    let(:spread)  { 5 }
    let(:day)     { 1 }
    let(:smallest_spread) { { value: 1, day: 1 } }
    let(:updated_smallest_spread) { { value: 5, day: 1 } }

    it 'initializes the spread hash' do
      Weather.init_spread(spread, day, smallest_spread).should be_true
      smallest_spread.should eq(updated_smallest_spread)
    end
  end

  describe '#compare_spreads' do
    let(:spread)  { 5 }
    let(:day)     { 1 }
    let(:smaller_spread) { { value: 1, day: 1 } }
    let(:larger_spread) { { value: 7, day: 1 } }
    let(:goal_spread) { { value: 5, day: 1 } }

    it 'updates hash if spread is smaller' do
      Weather.compare_spreads(spread, day, larger_spread)
      larger_spread.should eq(goal_spread)
    end

    it 'does not update the hash if spread is not smaller' do
      Weather.compare_spreads(spread, day, smaller_spread)
      smaller_spread.should eq(smaller_spread)
    end
  end

  describe '#process_file' do
    let(:smallest_spread) { { value: 2, day: 14 } }

    it 'scans the file and returns the correct smallest spread' do
      Weather.process_file("./bin/weather.dat").should eq(smallest_spread)
    end
  end
end
