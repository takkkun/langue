require 'langue/morphemes'
require 'langue/word'

module Langue
  class Sentence < Array
    def valid?
      all? { |word| Word === word && word.valid? }
    end

    def words
      self
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
