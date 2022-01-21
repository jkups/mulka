class PortfolioComponent < ViewComponent::Base
  def initialize(portfolio_data:)
    @portfolio_data = portfolio_data
  end

  private

  attr_reader :portfolio_data

  def account_name
    portfolio_data.account.name
  end

  def total_number_of_properties
    number_with_delimiter(portfolio_data.portfolio_property_count)
  end

  def total_units_acquired
    number_with_delimiter(portfolio_data.total_units_acquired)
  end

  def total_portfolio_value
    number_to_currency(portfolio_data.total_portfolio_value)
  end

  def total_portfolio_fee
    number_to_currency(portfolio_data.total_portfolio_fee)
  end
end
