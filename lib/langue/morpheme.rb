module Langue
  class Morpheme
    KEYS = %w(
      text
      part_of_speech
      categories
      inflection
      inflection_type
      root_form
      yomi
      pronunciation
    ).map &:to_sym

    def initialize(attrs)
      KEYS.each {|key| instance_variable_set("@#{key}", attrs[key])}
    end

    attr_reader(*KEYS)

    def classified?(*categories)
      categories.zip(@categories).all? {|c| c[0] == c[1]}
    end
  end
end
