module DryCases
  module Containers
    extend Dry::Container::Mixin

    register :db_transaction, CustomAdapters::DbAdapter.new
  end
end
