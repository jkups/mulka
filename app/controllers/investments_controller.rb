class InvestmentsController < ApplicationController
  before_action :check_if_user_logged_in

  #ajax call to update displayed price
  def update_price
    property = Property.find params[:id]
    result = property.calculate_price params[:input_shares]

    render json: {
      investment: result[:investment],
      trxn_fees: result[:trxn_fees],
      total_due: result[:total_due]
    }
  end

  def index
    @account = Account.find_by user_id: @current_user.id, account_active: true
    @investments = Investment.where account_id: @account.id, trxn_status: "successful"
    @investments = @investments.each { |inv| inv.property_name = inv.property.name }
  end

  def new
    @property = Property.find params[:id]
    @account = Account.find_by account_active: true, user_id: @current_user.id

    if @property.status != 'active'
      flash[:error] = "The property is not open for investment."
      redirect_to properties_path

    elsif @account.nil?
      flash[:error] = "You need to create an investment account."
      redirect_to new_account_path
    end
  end

  def create
    property = Property.find params[:id]

    if params[:input_shares].to_i > property.available_shares
      flash[:error] = 'There is not enough share units to acquire.'
      redirect_to new_investment_path(property.id) and return
    end

    result = property.calculate_price params[:input_shares]

    investment = Investment.create(
      invest_amount: result[:investment],
      invest_share: params[:input_shares],
      trxn_fee: result[:trxn_fees],
      total_due: result[:total_due],
      trxn_ref: (rand() * 100000000).round.to_s,
      property_id: params[:id],
      account_id: params[:account_id]
    )

    redirect_to new_pay_path(investment.id)
  end
end
