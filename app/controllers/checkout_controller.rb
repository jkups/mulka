class CheckoutController < ApplicationController
  def new
    @checkout = Forms::Checkout::Create.from_params(
      params: params,
      user: current_user
    )

    @account = current_user.account
  end

  def create
    @checkout = Forms::Checkout::Create.from_params(
      params: params,
      user: current_user
    )

    result = UseCases::Transactions::Create.call(@checkout)

    if result.success?
      flash[:notice] = "Transaction was successful."
      redirect_to portfolios_path
    else
      flash[:alert] = "Something went wrong."
      redirect_to root_path #TODO: redirect after unsuccessful transaction
    end
  end
end
