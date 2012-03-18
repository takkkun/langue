require 'langue/morpheme'

module Langue
  class Morphemes < Array
    def valid?
      all? {|morpheme| Morpheme === morpheme}
    end

    def at(index)
      morpheme = self[index]
      morpheme.nil? || !block_given? ? morpheme : yield(morpheme)
    end

#     def match?(index, text)
#       at(index) {|morpheme| morpheme.text == text}
#     end

#     def after(index)
#       self[index..-1]
#     end
  end
end
