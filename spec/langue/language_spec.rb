require 'langue/language'

module Example
  class LanguageExample < Langue::Language
    def parse(text)
      text
    end
    depend_to :parse, 'example/language_example/parser'
  end
end

describe Langue::Language, '.name' do
  it 'returns the class name based underscore' do
    Example::LanguageExample.name.should == 'language_example'
  end
end

describe Langue::Language, '.depend_to' do
  before do
    @language = Example::LanguageExample.new
  end

  it 'calls require method' do
    @language.should_receive(:require).with('example/language_example/parser')
    @language.parse('text')
  end

  it 'does not call require method more than once' do
    @language.should_not_receive(:require)
    @language.parse('text')
  end
end
