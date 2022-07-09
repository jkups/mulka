module Queries
  module QueryBase
    extend ActiveSupport::Concern

    module ClassMethods
      def perform(args = {})
        new(**args).query
      end
    end

    def query
      raise NotImplementedError, "All query objects must implement a #query method"
    end
  end
end
