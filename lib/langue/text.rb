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
      @words ||= inject(&:+)
    end

    def morphemes
      @morphemes ||= Morphemes.new(flatten)
    end
  end
end
