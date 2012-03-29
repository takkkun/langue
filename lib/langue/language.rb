require 'active_support/core_ext/string/inflections'

require 'langue/exceptions'

module Langue
  class Language
    class << self
      def id
        parts = name.split('::').reverse.drop_while { |part| part == 'Language' }
        raise InvalidDefinition, "'#{name}' is invalid definition" if parts.empty?
        parts.first.underscore
      end

      def depend_to(orig_method_name, *gems)
        method_name = "_#{orig_method_name}"
        alias_method(method_name, orig_method_name) unless respond_to?(method_name)

        define_method(orig_method_name) do |*args|
          gems.each {|gem| require gem}
          value = __send__(method_name, *args)
          self.class.class_eval { alias_method(orig_method_name, method_name) }
          value
        end
      end
    end

    def initialize(options = {})
      @options = options
    end
  end
end
