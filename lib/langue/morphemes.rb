require 'langue/morpheme'

module Langue
  class Morphemes < Array
    def valid?
      all? { |morpheme| Morpheme === morpheme }
    end

    def at(index)
      morpheme = self[index]
      morpheme.nil? || !block_given? ? morpheme : yield(morpheme)
    end

    def pad(text)
      whitespace_regexp = /^([\x09\x0A\x0B\x20])+/
      differece_error = ArgumentError.new('maybe different from the original text')

      morphemes = Morphemes.new
      index = 0

      while index < size
        morpheme = self[index]
        morpheme_text = morpheme.text

        if text[0, morpheme_text.size] == morpheme_text
          text = text[morpheme_text.size..-1]
          morphemes << morpheme
          index += 1
        elsif text =~ whitespace_regexp
          whitespace = $1
          text = text[whitespace.size..-1]
          morphemes << create_padding(whitespace)
        else
          raise differece_error
        end
      end

      if text =~ /#{whitespace_regexp}$/
        morphemes << create_padding(text)
      elsif !text.empty?
        raise differece_error
      end

      morphemes
    end

    private

    def create_padding(whitespace)
      Morpheme.new(
        :text           => whitespace,
        :part_of_speech => 'padding',
        :categories     => [],
        :root_form      => whitespace
      )
    end
  end
end
