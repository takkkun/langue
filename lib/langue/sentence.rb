require 'langue/morphemes'

module Langue
  class Sentence < Array
    def words
      self
    end

    def morphemes
      @morphemes ||= Morphemes.new(flatten)
    end
  end
end
