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

    def classified?(part_of_speech, *categories)
      got = [@part_of_speech] + @categories
      expected = [part_of_speech] + categories
      expected.zip(got).all? { |pair| pair[0] == pair[1] }
    end
  end
end
