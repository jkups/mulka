class ExpressionOfInterestComponent < ViewComponent::Base
  delegate :render_svg, to: :helpers

  def initialize(eoi:)
    @eoi = eoi
  end

  private

  attr_reader :eoi

  def refresh_path
    new_buyer_app_offer_expression_of_interest_path(offer_id: eoi.offer.id)
  end

  def price_per_unit
    calc_price_per_unit = eoi.price / eoi.total_units
    number_to_currency(calc_price_per_unit)
  end

  def units_available
    number_with_delimiter(eoi.available_units)
  end

  def eoi_subtotal
    number_to_currency(eoi.eoi_subtotal)
  end

  def eoi_fee
    number_to_currency(eoi.eoi_fee)
  end

  def eoi_grand_total
    number_to_currency(eoi.eoi_grand_total)
  end

  def minimum_unit_required
    minimum_unit = eoi.minimum_units
    t(".minimum_unit", unit: minimum_unit)
  end

  def property_image_path
    cl_image_path(eoi.image)
  end

  def property_image_with_details
    content_tag(:div,
      class: "bg-cover bg-no-repeat h-full relative", style: "background-image: url(#{property_image_path})") do
        children = available_unit
        children << property_details
    end
  end

  def available_unit
    content_tag(:div, class: "absolute top-0 mx-4 px-4 pt-12 pb-4 bg-green-500 text-white rounded-b-xl shadow-lg lg:mx-8") do
      children = content_tag(:p, t(".available_units"), class: "text-xs")
      children << content_tag(:p, units_available, class: "text-2xl font-semibold")
    end
  end

  def property_details
    content_tag(:div, class: "flex justify-between py-8 px-4 bg-gray-100 bg-opacity-80 absolute inset-x-0 bottom-0 lg:px-8") do
      children = property_name_and_yield_tag
      children << property_price_and_min_investment_tag
    end
  end

  def property_name_and_yield_tag
    content_tag(:div) do
      children = content_tag(:h3, eoi.name, class: "text-xl font-bold")
      children << content_tag(:p, t(".estimated_yield", yield: 10))
    end
  end

  def property_price_and_min_investment_tag
    content_tag(:div, class: "hidden text-right lg:block") do
      children = content_tag(:h3, t(".price_per_unit", price_per_unit: price_per_unit), class: "text-xl font-semibold")
      children << content_tag(:p, minimum_unit_required)
    end
  end
end
