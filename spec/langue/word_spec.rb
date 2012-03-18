require 'langue/word'

describe Langue::Word, '#valid?' do
  before do
    @word = described_class.new([
      Langue::Morpheme.new({}),
      Langue::Morpheme.new({}),
      Langue::Morpheme.new({})
    ])
  end

  context 'with all morphemes' do
    it 'returns true' do
      @word.should be_valid
    end
  end

  context 'with including non-morpheme' do
    before do
      @word[1] = 'invalid_as_morpheme'
    end

    it 'returns false' do
      @word.should_not be_valid
    end
  end
end

describe Langue::Word, '#morphemes' do
  before do
    word = described_class.new([1, 2, 3])
    @morphemes = word.morphemes
  end

  it 'returns an instance of Langue::Morphemes' do
    @morphemes.should be_a Langue::Morphemes
  end

  it 'returns ' do
    @morphemes.should == [1, 2, 3]
  end
end

describe Langue::Word, '#key_morpheme' do
  before do
    word = described_class.new([1, 2, 3])
    @morpheme = word.key_morpheme
  end

  it 'returns the last morpheme' do
    @morpheme.should == 3
  end

  context 'with do not have morphemes' do
    before do
      word = described_class.new
      @morpheme = word.key_morpheme
    end

    it 'returns nil' do
      @morpheme.should be_nil
    end
  end
end

describe Langue::Word, '#text' do
  before do
    word = described_class.new([
      stub.tap {|s| s.stub!(:text).and_return('text1')},
      stub.tap {|s| s.stub!(:text).and_return('text2')},
      stub.tap {|s| s.stub!(:text).and_return('text3')}
    ])

    @text = word.text
  end

  it 'returns a concatenated string of the text of the morphemes' do
    @text.should == 'text1text2text3'
  end
end

describe Langue::Word, '#inflection' do
  before do
    word = described_class.new([
      stub.tap {|s| s.stub!(:inflection).and_return('inflection1')},
      stub.tap {|s| s.stub!(:inflection).and_return('inflection2')},
      stub.tap {|s| s.stub!(:inflection).and_return('inflection3')},
    ])

    @inflection = word.inflection
  end

  it 'returns the inflection of the last morpheme' do
    @inflection.should == 'inflection3'
  end

  context 'with do not have morphemes' do
    before do
      word = described_class.new
      @inflection = word.inflection
    end

    it 'returns nil' do
      @inflection.should be_nil
    end
  end
end

describe Langue::Word, '#inflection_type' do
  before do
    word = described_class.new([
      stub.tap {|s| s.stub!(:inflection_type).and_return('inflection_type1')},
      stub.tap {|s| s.stub!(:inflection_type).and_return('inflection_type2')},
      stub.tap {|s| s.stub!(:inflection_type).and_return('inflection_type3')},
    ])

    @inflection_type = word.inflection_type
  end

  it 'returns the type of the inflection of the last morpheme' do
    @inflection_type.should == 'inflection_type3'
  end

  context 'with do not have morphemes' do
    before do
      word = described_class.new
      @inflection_type = word.inflection_type
    end

    it 'returns nil' do
      @inflection_type.should be_nil
    end
  end
end

describe Langue::Word, '#root_form' do
  before do
    word = described_class.new([
      stub.tap {|s| s.stub!(:text).and_return('text1')},
      stub.tap {|s| s.stub!(:text).and_return('text2')},
      stub.tap {|s| s.stub!(:root_form).and_return('root_form3')},
    ])

    @root_form = word.root_form
  end

  it 'makes only the last of the text of the morphemes the root form, and returns a concatenated string' do
    @root_form.should == 'text1text2root_form3'
  end

  context 'with have a morpheme' do
    before do
      word = described_class.new([
        stub.tap {|s| s.stub!(:root_form).and_return('root_form1')}
      ])

      @root_form = word.root_form
    end

    it 'returns the root form text of the morpheme' do
      @root_form.should == 'root_form1'
    end
  end

  context 'with do not have morphemes' do
    before do
      word = described_class.new
      @root_form = word.root_form
    end

    it 'returns nil' do
      @root_form.should be_nil
    end
  end
end

describe Langue::Word, '#yomi' do
  before do
    word = described_class.new([
      stub.tap {|s| s.stub!(:yomi).and_return('yomi1')},
      stub.tap {|s| s.stub!(:yomi).and_return('yomi2')},
      stub.tap {|s| s.stub!(:yomi).and_return('yomi3')},
    ])

    @yomi = word.yomi
  end

  it 'returns a concatenated string of the yomi of the morphemes' do
    @yomi.should == 'yomi1yomi2yomi3'
  end

  context 'with have morpheme without a yomi' do
    before do
      word = described_class.new([
        stub.tap {|s| s.stub!(:yomi).and_return('yomi1')},
        stub.tap {|s| s.stub!(:yomi).and_return(nil)},
        stub.tap {|s| s.stub!(:yomi).and_return('yomi3')},
      ])

      @yomi = word.yomi
    end

    it 'returns nil' do
      @yomi.should be_nil
    end
  end

  context 'with do not have morphemes' do
    before do
      word = described_class.new
      @yomi = word.yomi
    end

    it 'returns nil' do
      @yomi.should be_nil
    end
  end
end

describe Langue::Word, '#pronunciation' do
  before do
    word = described_class.new([
      stub.tap {|s| s.stub!(:pronunciation).and_return('pronunciation1')},
      stub.tap {|s| s.stub!(:pronunciation).and_return('pronunciation2')},
      stub.tap {|s| s.stub!(:pronunciation).and_return('pronunciation3')},
    ])

    @pronunciation = word.pronunciation
  end

  it 'returns a concatenated string of the pronunciation of the morphemes' do
    @pronunciation.should == 'pronunciation1pronunciation2pronunciation3'
  end

  context 'with have morpheme without a pronunciation' do
    before do
      word = described_class.new([
        stub.tap {|s| s.stub!(:pronunciation).and_return('pronunciation1')},
        stub.tap {|s| s.stub!(:pronunciation).and_return(nil)},
        stub.tap {|s| s.stub!(:pronunciation).and_return('pronunciation3')},
      ])

      @pronunciation = word.pronunciation
    end

    it 'returns nil' do
      @pronunciation.should be_nil
    end
  end

  context 'with do not have morphemes' do
    before do
      word = described_class.new
      @pronunciation = word.pronunciation
    end

    it 'returns nil' do
      @pronunciation.should be_nil
    end
  end
end
