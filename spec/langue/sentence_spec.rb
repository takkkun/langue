require 'langue/sentence'

describe Langue::Sentence, '#words' do
  before do
    sentence = described_class.new([[1, 2], [3, 4]])
    @words = sentence.words
  end

  it 'returns an instance of Array' do
    @words.should be_an Array
  end

  it 'returns the words' do
    @words.should == [[1, 2], [3, 4]]
  end
end

describe Langue::Sentence, '#morphemes' do
  before do
    sentence = described_class.new([[1, 2], [3, 4]])
    @morphemes = sentence.morphemes
  end

  it 'returns an instance of Langue::Morphemes' do
    @morphemes.should be_a Langue::Morphemes
  end

  it 'returns the morphemes in the words' do
    @morphemes.should == [1, 2, 3, 4]
  end
end
