module DryCases
  module CustomAdapters
    class DbAdapter
      include Dry::Monads::Result::Mixin

      def call(input, &block)
        result = Failure.new(errors: {})

        ActiveRecord::Base.transaction do
          result = block.(Success.new(input))
          raise ActiveRecord::Rollback if result.failure?
        end

        result.failure? ? Failure.new(result.value) : result
      end
    end
  end
end
