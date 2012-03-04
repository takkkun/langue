require 'langue/version'
require 'langue/exceptions'

module Langue
  extend self

  @languages = {}

  def languages
    @languages.values
  end

  def support(language_class)
    id = to_language_id(language_class)
    raise LanguageAlreadySupported, "'#{language_class.name}' language is supported already" if @languages.key?(id)
    @languages[id] = language_class
  end

  def unsupport(language_spec)
    id = to_language_id(language_spec)
    raise unsupported!(language_spec) unless @languages.key?(id)
    @languages.delete(id)
  end

  def unsupport_all
    @languages.clear
  end

  def language(language_spec)
    id = to_language_id(language_spec)
    raise unsupported!(language_spec) unless @languages.key?(id)
    @languages[id]
  end
  alias [] language

  private

  def to_language_id(language_spec)
    Class === language_spec ? language_spec.id : language_spec.to_s.downcase
  end

  def unsupported!(language_spec)
    name = Class === language_spec ? language_spec.name : language_spec
    raise LanguageUnsupported, "'#{name}' language is unsupported"
  end
end
