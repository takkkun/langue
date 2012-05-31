# -*- coding: utf-8 -*-
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
      @morphemes.at(0) { |morpheme| morpheme.should == 1 }
    end

    it 'returns the value returned from the block' do
      value = @morphemes.at(0) { |morpheme| 'value' }
      value.should == 'value'
    end

    context 'with do not have a morpheme at the position of the index' do
      it 'does not call the block' do
        lambda { @morphemes.at(3) { |morpheme| fail } }.should_not raise_error
      end

      it 'returns nil' do
        value = @morphemes.at(3) { |morpheme| fail }
        value.should be_nil
      end
    end
  end
end

describe Langue::Morphemes, '#pad' do
  before do
    @morphemes = morphemes = described_class.new([
      Langue::Morpheme.new(:text => 'text1'),
      Langue::Morpheme.new(:text => 'text2'),
      Langue::Morpheme.new(:text => 'text3')
    ])
  end

  it 'pads \\x09' do
    padded_morphemes = @morphemes.pad("text1\x09text2text3\x09")
    padded_morphemes.should have(5).items
    morpheme = padded_morphemes[1]
    morpheme.text.should == "\x09"
    morpheme.root_form.should == "\x09"
    morpheme = padded_morphemes[4]
    morpheme.text.should == "\x09"
    morpheme.root_form.should == "\x09"
  end

  it 'pads \\x0A' do
    padded_morphemes = @morphemes.pad("text1\x0Atext2text3\x0A")
    padded_morphemes.should have(5).items
    morpheme = padded_morphemes[1]
    morpheme.text.should == "\x0A"
    morpheme.root_form.should == "\x0A"
    morpheme = padded_morphemes[4]
    morpheme.text.should == "\x0A"
    morpheme.root_form.should == "\x0A"
  end

  it 'pads \\x0B' do
    padded_morphemes = @morphemes.pad("text1\x0Btext2text3\x0B")
    padded_morphemes.should have(5).items
    morpheme = padded_morphemes[1]
    morpheme.text.should == "\x0B"
    morpheme.root_form.should == "\x0B"
    morpheme = padded_morphemes[4]
    morpheme.text.should == "\x0B"
    morpheme.root_form.should == "\x0B"
  end

  it 'pads \\x20' do
    padded_morphemes = @morphemes.pad("text1\x20text2text3\x20")
    padded_morphemes.should have(5).items
    morpheme = padded_morphemes[1]
    morpheme.text.should == "\x20"
    morpheme.root_form.should == "\x20"
    morpheme = padded_morphemes[4]
    morpheme.text.should == "\x20"
    morpheme.root_form.should == "\x20"
  end

  it 'raises ArgumentError if there is a difference between the text and the morphemes' do
    lambda { @morphemes.pad("text1\x20text3text4") }.should raise_error(ArgumentError, 'maybe different from the original text')
    lambda { @morphemes.pad('text1text2text3text4text5') }.should raise_error(ArgumentError, 'maybe different from the original text')
  end
end
