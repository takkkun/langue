require 'langue'
require 'langue/language'

class LanguageExample      < Langue::Language; end
class OtherLanguageExample < Langue::Language; end

describe Langue do
  it 'is an instance of Module' do
    described_class.should be_an_instance_of Module
  end

  it 'has VERSION constant' do
    described_class.should be_const_defined :VERSION
  end
end

describe Langue, '.languages' do
  before do
    @languages = described_class.languages
  end

  it 'returns an instance of Array' do
    @languages.should be_an Array
  end

  it 'returns an empty array in default' do
    @languages.should be_empty
  end
end

describe Langue, '.support' do
  before do
    described_class.unsupport_all
    described_class.support(LanguageExample)
  end

  it 'adds to the supported languages' do
    language = described_class.languages.first
    language.should == LanguageExample
  end

  context 'with already a supported language' do
    it "raises #{described_class}::LanguageAlreadySupported" do
      lambda { described_class.support(LanguageExample) }.should raise_error(Langue::LanguageAlreadySupported, /LanguageExample/)
    end
  end
end

describe Langue, '.unsupport' do
  before do
    described_class.unsupport_all
    described_class.support(LanguageExample)
    described_class.unsupport(LanguageExample)
  end

  it 'removes from the supported languages' do
    languages = described_class.languages
    languages.should be_empty
  end

  context 'with not a class' do
    before do
      described_class.unsupport_all
      described_class.support(LanguageExample)
      described_class.unsupport('language_example')
    end

    it 'removes from the supported languages' do
      languages = described_class.languages
      languages.should be_empty
    end
  end

  context 'with an unsupported language' do
    before do
      described_class.unsupport_all
    end

    it "raises #{described_class}::LanguageUnsupported" do
      lambda { described_class.unsupport(OtherLanguageExample) }.should raise_error(Langue::LanguageUnsupported, /OtherLanguageExample/)
    end

    context 'with not a language class' do
      it "raises #{described_class}::LanguageUnsupported" do
        lambda { described_class.unsupport('other_language_example') }.should raise_error(Langue::LanguageUnsupported, /other_language_example/)
      end
    end
  end
end

describe Langue, '.unsupport_all' do
  it 'removes all languages from the supported languages' do
    described_class.support(LanguageExample)
    described_class.support(OtherLanguageExample)
    described_class.languages.should_not be_empty
    described_class.unsupport_all
    described_class.languages.should be_empty
  end
end

describe Langue, '.language' do
  before do
    described_class.unsupport_all
    described_class.support(LanguageExample)
  end

  it 'returns the language class' do
    language = described_class.language('language_example')
    language.should == LanguageExample
  end

  context 'with an unsupported language' do
    it "raises #{described_class}::LanguageUnsupported" do
      lambda { described_class.language('other_language_example') }.should raise_error(Langue::LanguageUnsupported)
    end
  end
end

describe Langue, '.[]' do
  before do
    described_class.unsupport_all
    described_class.support(LanguageExample)
  end

  it 'returns the language class' do
    language = described_class['language_example']
    language.should == LanguageExample
  end

  context 'with an unsupported language' do
    it "raises #{described_class}::LanguageUnsupported" do
      lambda { described_class['other_language_example'] }.should raise_error(Langue::LanguageUnsupported)
    end
  end
end
