require_relative '../lib/position'

describe Position do
  describe '#valid?' do
    it 'returns true if the position is valid' do
      pos = Position.new(3, 5)
      bool = pos.valid?
      expect(true).to eq(bool)
    end

    it 'returns false if the position is invalid' do
      pos = Position.new(3, 8)
      bool = pos.valid?
      expect(false).to eq(bool)
    end

    it 'returns false if position is invalid' do
      pos = Position.new(8, 8)
      bool = pos.valid?
      expect(false).to eq(bool)
    end
  end

  describe '==' do
    it 'checks if two position objects are equal' do
      position = Position.new(3, 3)
      position2 = Position.new(3, 3)
      expect(true).to eq(position == position2)
    end
  end
end
