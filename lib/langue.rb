require 'langue/version'
require 'langue/exceptions'

module Langue
  extend self

  @languages = {}

  def languages
    @languages.values
  end

  def support(language_class)
    name = language_class.name
    raise LanguageAlreadySupported, "'#{language_class.__name__}' language is supported already" if @languages.key?(name)
    @languages[name] = language_class
  end

  def unsupport(language_spec)
    key = to_language_key(language_spec)
    raise unsupported!(language_spec) unless @languages.key?(key)
    @languages.delete(key)
  end

  def unsupport_all
    @languages.clear
  end

  def language(language_spec)
    key = to_language_key(language_spec)
    raise unsupported!(language_spec) unless @languages.key?(key)
    @languages[key]
  end
  alias [] language

  private

  def to_language_key(language_spec)
    Class === language_spec ? language_spec.name : language_spec.to_s.downcase
  end

  def unsupported!(language_spec)
    name = Class === language_spec ? language_spec.__name__ : language_spec
    raise LanguageUnsupported, "'#{name}' language is unsupported"
  end
end
