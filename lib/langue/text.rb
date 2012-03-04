require 'langue/morphemes'

module Langue
  class Text < Array
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
