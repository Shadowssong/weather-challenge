require 'spec_helper'

describe Weather do
  describe '#contain_column_names?' do
    it 'returns true if parsed line contains column names' do
      true
    end

    it 'returns false if parsed line does not contain column names' do
      false
    end
  end

  describe '#calculate_spread' do
    it 'properly calculates the spread' do
      true
    end
  end

  describe '#init spread' do
    it 'initializes the spread hash' do
      true
    end
  end

  describe '#compare_spreads' do
    it 'updates hash if spread is smaller' do
      true
    end

    it 'does not update the hash if spread is not smaller' do
      false
    end
  end

  describe '#process_file' do
    it 'scans the file and returns the correct smallest spread' do
      true
    end
  end
end
