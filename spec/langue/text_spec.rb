require 'langue/text'

describe Langue::Text, '#valid?' do
  before do
    @text = described_class.new([
      Langue::Sentence.new,
      Langue::Sentence.new,
      Langue::Sentence.new
    ])
  end

  context 'with all sentences' do
    it 'returns true' do
      @text.should be_valid
    end
  end

  context 'with including non-sentence' do
    before do
      @text[1] = 'invalid_as_sentence'
    end

    it 'returns false' do
      @text.should_not be_valid
    end
  end
end

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

describe Langue::Text, '#text' do
  it 'returns a concatenated string of the text of the sentences' do
    text = described_class.new([
      stub(Langue::Sentence).tap { |s| s.stub!(:text).and_return('sentence1') },
      stub(Langue::Sentence).tap { |s| s.stub!(:text).and_return('sentence2') }
    ])

    text.text.should == 'sentence1sentence2'
  end

  it 'returns nil if the text is empty' do
    text = described_class.new
    text.text.should be_nil
  end
end
