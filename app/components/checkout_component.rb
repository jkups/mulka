class CheckoutComponent < ViewComponent::Base
  delegate :render_svg, to: :helpers

  def initialize(tranzaction:)
    @tranzaction = tranzaction
  end

  private

  attr_reader :tranzaction

  def braintree_nonce_prefix
    ENV["BRAINTREE_NONCE_PREFIX"]
  end

  def paypal_client_id
    ENV["PAYPAL_CLIENT_ID"]
  end

  def braintree_client_authorization
    ENV["BRAINTREE_CLIENT_AUTHORIZATION"]
  end

  def active_portfolio
    tranzaction.portfolio
  end

  def refresh_path
    new_buyer_app_offer_tranzaction_path(offer_id: tranzaction.offer.id)
  end

  def price_per_unit
    calc_price_per_unit = tranzaction.price / tranzaction.total_units
    number_to_currency(calc_price_per_unit)
  end

  def units_available
    number_with_delimiter(tranzaction.available_units)
  end

  def tranzaction_subtotal
    number_to_currency(tranzaction.tranzaction_subtotal)
  end

  def tranzaction_fee
    number_to_currency(tranzaction.tranzaction_fee)
  end

  def tranzaction_grand_total
    number_to_currency(tranzaction.tranzaction_grand_total)
  end

  def minimum_unit_required
    minimum_unit = tranzaction.minimum_units
    t(".minimum_unit", unit: minimum_unit)
  end

  def property_image_path
    cl_image_path(tranzaction.image)
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
      children = content_tag(:p, t(".available_units"), class: "text-xs")
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
      children = content_tag(:h3, tranzaction.name, class: "text-xl font-bold")
      children << content_tag(:p, t(".estimated_yield", yield: 10))
    end
  end

  def property_price_and_min_investment_tag
    content_tag(:div, class: "text-right") do
      children = content_tag(:h3, t(".price_per_unit", price_per_unit: price_per_unit), class: "text-xl font-semibold")
      children << content_tag(:p, minimum_unit_required)
    end
  end
end
