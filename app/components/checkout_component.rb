class CheckoutComponent < ViewComponent::Base
  def initialize(property:, account:)
    @property = property
    @account = account
  end

  private

  attr_reader :property, :account

  def braintree_nonce_prefix
    ENV["BRAINTREE_NONCE_PREFIX"]
  end

  def paypal_client_id
    ENV["PAYPAL_CLIENT_ID"]
  end

  def braintree_client_authorization
    ENV["BRAINTREE_CLIENT_AUTHORIZATION"]
  end

  def refresh_path
    new_property_checkout_path(property.property_id)
  end

  def price_per_unit
    calc_price_per_unit = property.listing_price / property.total_units
    number_to_currency(calc_price_per_unit)
  end

  def units_available
    number_with_delimiter(property.available_units)
  end

  def transaction_subtotal
    number_to_currency(property.transaction_subtotal)
  end

  def transaction_fee
    number_to_currency(property.transaction_fee)
  end

  def transaction_grand_total
    number_to_currency(property.transaction_grand_total)
  end

  def minimum_unit_required
    minimum_unit = property.number_of_units
    t(".minimum_unit", unit: minimum_unit)
  end

  def property_image_path
    cl_image_path(property.image)
  end

  def prevent_decimal_value
    "this.value=(parseInt(this.value))"
  end

  def property_image_with_details
    content_tag(:div,
      class: "bg-cover bg-no-repeat h-108 relative", style: "background-image: url(#{property_image_path})") do
        children = available_unit
        children << property_details
    end
  end

  def available_unit
    content_tag(:div, class: "absolute top-0 mx-8 px-4 pt-12 pb-4 bg-green-500 text-white rounded-b-xl shadow-lg") do
      children = content_tag(:p, t(".avaliable_units"), class: "text-xs")
      children << content_tag(:p, units_available, class: "text-2xl font-semibold")
    end
  end

  def property_details
    content_tag(:div, class: "flex justify-between p-8 bg-gray-100 bg-opacity-80 absolute inset-x-0 bottom-0") do
      children = property_name_and_yield_tag
      children << property_price_and_min_investment_tag
    end
  end

  def property_name_and_yield_tag
    content_tag(:div) do
      children = content_tag(:h3, property.name, class: "text-xl font-bold")
      children << content_tag(:p, "Yield: 10%")
    end
  end

  def property_price_and_min_investment_tag
    content_tag(:div) do
      children = content_tag(:h3, price_per_unit, class: "text-xl font-semibold")
      children << content_tag(:p, minimum_unit_required)
    end
  end
end
