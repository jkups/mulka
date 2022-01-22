module Calculator
  module Portfolios
    class Index
      include ActiveModel::Model

      attr_reader :account,
        :portfolio_property_count,
        :total_units_acquired,
        :total_portfolio_value,
        :total_portfolio_fee

      TrxnSummary = Struct.new(
        :property_id, :property_name, :property_image, :unit_subtotal, :value_subtotal, :fee_subtotal, :transactions
      )

      class << self
        def group_by_property(transactions:, account:)
          grouped_transactions = transactions.group_by(&:property_id)
          portfolio_property_count = grouped_transactions.size
          calculate_totals = calculate_totals(transactions)

          new(
            account: account,
            grouped_transactions: grouped_transactions,
            portfolio_property_count: portfolio_property_count,
            **calculate_totals
          )
        end

        def calculate_totals(transactions)
          {
            total_units_acquired: transactions.sum(:units),
            total_portfolio_value: transactions.sum(:value),
            total_portfolio_fee: transactions.sum(:fee)
          }
        end
      end

      def initialize(account:, portfolio_property_count:, total_units_acquired:, total_portfolio_value:, total_portfolio_fee:, grouped_transactions:)
        @account = account
        @portfolio_property_count = portfolio_property_count
        @total_units_acquired = total_units_acquired
        @total_portfolio_value = total_portfolio_value
        @total_portfolio_fee = total_portfolio_fee
        @grouped_transactions = grouped_transactions
      end

      def prepared_transactions
        grouped_transactions.map { |id, transactions| prepare_transactions(id, transactions) }
      end

      private

      attr_reader :grouped_transactions

      def prepare_transactions(id, transactions)
        property = Property.find(id)
        subtotals = prepare_subtotals(transactions)
        TrxnSummary.new(id, property.name, property.image, *subtotals, transactions)
      end

      def prepare_subtotals(transactions)
        [
          transactions.sum(&:units),
          transactions.sum(&:value),
          transactions.sum(&:fee)
        ]
      end
    end
  end
end
