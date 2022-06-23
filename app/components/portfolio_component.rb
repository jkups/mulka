class PortfolioComponent < ViewComponent::Base
  def initialize(grouped_portfolio:)
    @grouped_portfolio = grouped_portfolio
  end

  private

  attr_reader :grouped_portfolio

  def portfolio_name
    grouped_portfolio.portfolio.name
  end

  def portfolio_number
    grouped_portfolio.portfolio.number
  end

  def total_number_of_properties
    number_with_delimiter(grouped_portfolio.portfolio_property_count)
  end

  def total_units_acquired
    number_with_delimiter(grouped_portfolio.total_units_acquired)
  end

  def total_investment_amount
    number_to_currency(grouped_portfolio.total_investment_amount)
  end

  def total_tranzaction_fee
    number_to_currency(grouped_portfolio.total_tranzaction_fee)
  end
end
