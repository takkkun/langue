require 'langue/morphemes'
require 'langue/sentence'

module Langue
  class Text < Array
    def valid?
      all? { |sentence| Sentence === sentence && sentence.valid? }
    end

    def sentences
      self
    end

    def words
      @words ||= inject([], &:+)
    end

    def morphemes
      @morphemes ||= Morphemes.new(flatten)
    end

    def text
      @text = empty? ? nil : map(&:text).join unless instance_variable_defined?(:@text)
      @text
    end
  end
end
