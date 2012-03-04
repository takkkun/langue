require 'langue/morphemes'

module Langue
  class Word < Array
    alias key_morpheme last

    def morphemes
      @morphemes ||= Morphemes.new(self)
    end

    def text
      @text = not_empty? { map(&:text) } unless instance_variable_defined?(:@text)
      @text
    end

    def inflection
      @inflection = value_in_key_morpheme(:inflection) unless instance_variable_defined?(:@inflection)
      @inflection
    end

    def inflection_type
      @inflection_type = value_in_key_morpheme(:inflection_type) unless instance_variable_defined?(:@inflection_type)
      @inflection_type
    end

    def root_form
      @root_form = not_empty? { self[0..-2].map(&:text) + self[-1, 1].map(&:root_form) } unless instance_variable_defined?(:@root_form)
      @root_form
    end

    def yomi
      @yomi = join_values(:yomi) unless instance_variable_defined?(:@yomi)
      @yomi
    end

    def pronunciation
      @pronunciation = join_values(:pronunciation) unless instance_variable_defined?(:@pronunciation)
      @pronunciation
    end

    private

    def not_empty?
      empty? ? nil : yield.join
    end

    def value_in_key_morpheme(key)
      morpheme = key_morpheme
      morpheme.nil? ? nil : morpheme.__send__(key)
    end

    def join_values(key)
      empty? ? nil : begin
                       values = map(&key)
                       values.any? {|value| value.nil?} ? nil : values.join
                     end
    end
  end
end
