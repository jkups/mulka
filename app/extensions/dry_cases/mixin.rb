module DryCases
  module Mixin
    extend ActiveSupport::Concern

    module ClassMethods
      def call(input)
        new.call(input)
      end
    end

    def self.included(klass)
      klass.class_eval do
        include Dry::Transaction(container: DryCases::Containers)
        include Dry::Monads::Result::Mixin
      end
    end
  end
end
