require 'langue/morpheme'

describe Langue::Morpheme, ' accessors' do
  before do
    @morpheme = described_class.new(
      :text            => 'text',
      :part_of_speech  => 'part_of_speech',
      :categories      => %w(category1 category2),
      :inflection      => 'inflection',
      :inflection_type => 'inflection_type',
      :root_form       => 'root_form',
      :yomi            => 'yomi',
      :pronunciation   => 'pronunciation'
    )
  end

  it 'returns the text by text method' do
    @morpheme.text.should == 'text'
  end

  it 'returns the part of speech by part_of_speech method' do
    @morpheme.part_of_speech.should == 'part_of_speech'
  end

  it 'returns the categories by categories method' do
    @morpheme.categories.should == %w(category1 category2)
  end

  it 'returns the inflection by inflection method' do
    @morpheme.inflection.should == 'inflection'
  end

  it 'returns the type of the inflection by inflection_type method' do
    @morpheme.inflection_type.should == 'inflection_type'
  end

  it 'returns the root form by root_form method' do
    @morpheme.root_form.should == 'root_form'
  end

  it 'returns the yomi by yomi method' do
    @morpheme.yomi.should == 'yomi'
  end

  it 'returns the pronunciation by pronunciation method' do
    @morpheme.pronunciation.should == 'pronunciation'
  end
end

describe Langue::Morpheme, '#classified?' do
  before do
    @morpheme = described_class.new(
      :part_of_speech => 'part_of_speech',
      :categories     => %w(category1 category2)
    )
  end

  it 'returns true if part of speech matched' do
    @morpheme.should be_classified('part_of_speech')
  end

  it 'returns false if part of speech did not match' do
    @morpheme.should_not be_classified('part_0f_speech')
  end

  context 'with fewer than the categories' do
    it 'returns true if matched' do
      @morpheme.should be_classified('part_of_speech', 'category1')
    end

    it 'returns false if not matched' do
      @morpheme.should_not be_classified('part_of_speech', 'category10')
    end
  end

  context 'with equal to the categories' do
    it 'returns true if matched' do
      @morpheme.should be_classified('part_of_speech', 'category1', 'category2')
    end

    it 'returns false if not matched' do
      @morpheme.should_not be_classified('part_of_speech', 'category1', 'category20')
    end
  end

  context 'with many than the categories' do
    it 'returns false' do
      @morpheme.should_not be_classified('part_of_speech', 'category1', 'category2', 'category3')
    end
  end
end
