module BuyerApp
  class PortfoliosController < MainController
    def index
      active_portfolio = Queries::BuyerApp::Portfolios::FindCurrent.perform(
        buyer: current_buyer
      )

      @grouped_portfolio = Calculator::Portfolios::Index.group_by_property(
        tranzactions: active_portfolio.tranzactions,
        portfolio: active_portfolio
      )
    end
  end
end
