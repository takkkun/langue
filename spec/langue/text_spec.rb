require 'langue/text'

describe Langue::Text, '#sentences' do
  before do
    text = described_class.new([[[1, 2], [3, 4]], [[5, 6], [7, 8]]])
    @sentences = text.sentences
  end

  it 'returns an instance of Array' do
    @sentences.should be_an Array
  end

  it 'returns the sentences' do
    @sentences.should == [[[1, 2], [3, 4]], [[5, 6], [7, 8]]]
  end
end

describe Langue::Text, '#words' do
  before do
    text = described_class.new([[[1, 2], [3, 4]], [[5, 6], [7, 8]]])
    @words = text.words
  end

  it 'returns an instance of Array' do
    @words.should be_an Array
  end

  it 'returns the words in the sentences' do
    @words.should == [[1, 2], [3, 4], [5, 6], [7, 8]]
  end
end

describe Langue::Text, '#morphemes' do
  before do
    text = described_class.new([[[1, 2], [3, 4]], [[5, 6], [7, 8]]])
    @morphemes = text.morphemes
  end

  it 'returns an instance of Langue::Morphemes' do
    @morphemes.should be_a Langue::Morphemes
  end

  it 'returns the morphemes in the words in the sentences' do
    @morphemes.should == [1, 2, 3, 4, 5, 6, 7, 8]
  end
end
