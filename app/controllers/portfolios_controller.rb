class PortfoliosController < ApplicationController
  def index
    @portfolio_data = Calculator::Portfolios::Index.group_by_property(
      transactions: current_user.transactions,
      account: current_user.account
    )
  end
end
