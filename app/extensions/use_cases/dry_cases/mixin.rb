module UseCases
  module DryCases
    module Mixin
      module ClassMethods
        def call(input)
          new.call(input)
        end
      end

      def self.included(klass)
        klass.extend(ClassMethods)
        klass.class_eval do
          include Dry::Transaction
          include Dry::Monads::Result::Mixin
        end
      end
    end
  end
end
