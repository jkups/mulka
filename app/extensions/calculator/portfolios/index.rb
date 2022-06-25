module Calculator
  module Portfolios
    class Index
      include ActiveModel::Model

      attr_reader :portfolio
      attr_reader :portfolio_property_count
      attr_reader :total_units_acquired
      attr_reader :total_investment_amount
      attr_reader :total_tranzaction_fee

      TrxnSummary = Struct.new(
        :offer_id, :portfolio_id, :property_id, :property_name, :property_image, :entries, :unit_subtotal, :amount_subtotal, :fee_subtotal, keyword_init: true
      )

      class << self
        def group_by_property(tranzactions:, portfolio:)
          grouped_tranzactions = tranzactions.order(created_at: :desc).group_by(&:offer_id)
          portfolio_property_count = grouped_tranzactions.size
          calculate_totals = calculate_totals(tranzactions)

          new(
            portfolio: portfolio,
            grouped_tranzactions: grouped_tranzactions,
            portfolio_property_count: portfolio_property_count,
            **calculate_totals
          )
        end

        def calculate_totals(tranzactions)
          {
            total_units_acquired: tranzactions.sum(:units),
            total_investment_amount: tranzactions.sum(:amount),
            total_tranzaction_fee: tranzactions.sum(:fee)
          }
        end
      end

      def initialize(portfolio:, portfolio_property_count:, total_units_acquired:, total_investment_amount:, total_tranzaction_fee:, grouped_tranzactions:)
        @portfolio = portfolio
        @portfolio_property_count = portfolio_property_count
        @total_units_acquired = total_units_acquired
        @total_investment_amount = total_investment_amount
        @total_tranzaction_fee = total_tranzaction_fee
        @grouped_tranzactions = grouped_tranzactions
      end

      def prepared_tranzactions
        grouped_tranzactions.map { |offer_id, tranzactions| prepare_tranzactions(offer_id, tranzactions) }
      end

      private

      attr_reader :grouped_tranzactions

      def prepare_tranzactions(offer_id, tranzactions)
        offer = Queries::BuyerApp::Offers::FindById.perform(offer_id: offer_id)

        TrxnSummary.new(
          offer_id: offer.id,
          portfolio_id: portfolio.id,
          property_id: offer.property_id,
          property_name: offer.property.name,
          property_image: offer.property.image,
          entries: tranzactions,
          **prepare_subtotals(tranzactions)
        )
      end

      def prepare_subtotals(tranzactions)
        {
          unit_subtotal: tranzactions.sum(&:units),
          amount_subtotal: tranzactions.sum(&:amount),
          fee_subtotal: tranzactions.sum(&:fee)
        }
      end
    end
  end
end
