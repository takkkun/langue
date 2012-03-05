require 'langue/morphemes'

describe Langue::Morphemes, '#valid?' do
  before do
    @morphemes = described_class.new([
      Langue::Morpheme.new({}),
      Langue::Morpheme.new({}),
      Langue::Morpheme.new({})
    ])
  end

  context 'with all morphemes' do
    it 'returns true' do
      @morphemes.should be_valid
    end
  end

  context 'with including non-morpheme' do
    before do
      @morphemes[1] = 'invalid_as_morpheme'
    end

    it do
      @morphemes.should_not be_valid
    end
  end
end

describe Langue::Morphemes, '#at' do
  before do
    @morphemes = described_class.new([1, 2, 3])
  end

  it 'returns a morpheme at the position of the index' do
    morpheme = @morphemes.at(0)
    morpheme.should == 1
  end

  context 'with do not have a morpheme at the position of the index' do
    it 'returns nil' do
      morpheme = @morphemes.at(3)
      morpheme.should be_nil
    end
  end

  context 'with a block' do
    it 'passes to the block a morpheme at the position of the index' do
      @morphemes.at(0) {|morpheme| morpheme.should == 1}
    end

    it 'returns the value returned from the block' do
      value = @morphemes.at(0) {|morpheme| 'value'}
      value.should == 'value'
    end

    context 'with do not have a morpheme at the position of the index' do
      it 'does not call the block' do
        lambda { @morphemes.at(3) {|morpheme| fail} }.should_not raise_error
      end

      it 'returns nil' do
        value = @morphemes.at(3) {|morpheme| fail}
        value.should be_nil
      end
    end
  end
end

# describe Langue::Morphemes, '#match?' do
# end

# describe Langue::Morphemes, '#after' do
# end
