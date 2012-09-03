require 'langue/sentence'

describe Langue::Sentence, '#valid?' do
  before do
    @sentence = described_class.new([
      Langue::Word.new,
      Langue::Word.new,
      Langue::Word.new
    ])
  end

  context 'with all words' do
    it 'returns true' do
      @sentence.should be_valid
    end
  end

  context 'with including non-word' do
    before do
      @sentence[1] = 'invalid_as_word'
    end

    it 'returns false' do
      @sentence.should_not be_valid
    end
  end
end

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

describe Langue::Sentence, '#text' do
  it 'returns a concatenated string of the text of the words' do
    sentence = described_class.new([
      stub(Langue::Word).tap { |s| s.stub!(:text).and_return('word1') },
      stub(Langue::Word).tap { |s| s.stub!(:text).and_return('word2') }
    ])

    sentence.text.should == 'word1word2'
  end

  it 'returns nil if the sentence is empty' do
    sentence = described_class.new
    sentence.text.should be_nil
  end
end
