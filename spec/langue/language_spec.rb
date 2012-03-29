require 'langue/language'

module Example
  class LanguageExample < Langue::Language
    def parse(text)
      text
    end
    depend_to :parse, 'example/language_example/parser'
  end

  class Language < Langue::Language
  end
end

class Language < Langue::Language
end

describe Langue::Language, '.id' do
  it 'returns the class name based underscore' do
    Example::LanguageExample.id.should == 'language_example'
  end

  it 'returns the class name of the parent that are separated by the namespace if the name of the language class is "Language"' do
    Example::Language.id.should == 'example'
  end

  it 'raises Langue::InvalidDefinition if the name of the language class is "Language" and it is the top level object' do
    lambda { Language.id }.should raise_error(Langue::InvalidDefinition, /'Language'/)
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
