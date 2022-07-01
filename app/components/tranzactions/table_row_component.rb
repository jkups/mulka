module Tranzactions
  class TableRowComponent < ViewComponent::Base
    THUMBNAIL_SIZE = {width: 80}.freeze
    ROW_COLOR = {odd: "bg-white", even: "bg-gray-100"}.freeze
    private_constant :THUMBNAIL_SIZE, :ROW_COLOR

    with_collection_parameter :prepared_tranzaction

    def initialize(prepared_tranzaction:, prepared_tranzaction_counter:)
      @prepared_tranzaction = prepared_tranzaction
      @prepared_tranzaction_counter = prepared_tranzaction_counter
    end

    private

    attr_reader :prepared_tranzaction, :prepared_tranzaction_counter

    def toggle_tranzactions_button
      content_tag(
        :span,
        class: "px-2 mr-4 cursor-pointer transform hidden md:block",
        data: {action: "click->portfolio#toggleTrxnContainer", id: offer_id}
      ) { tag.i class: "fas fa-chevron-down text-base text-green-500" }
    end

    def property_thumbnail
      cl_image_tag(
        prepared_tranzaction.property_image,
        width: THUMBNAIL_SIZE[:width],
        crop: "fill"
      )
    end

    def offer_id
      prepared_tranzaction.offer_id
    end

    def property_id
      prepared_tranzaction.property_id
    end

    def portfolio_id
      prepared_tranzaction.portfolio_id
    end

    def property_name
      prepared_tranzaction.property_name
    end

    def view_property
      path = buyer_app_portfolio_settled_property_path(portfolio_id: portfolio_id, id: property_id)

      content_tag(:a, href: path, target: "_blank") do
        i_tag = tag.i class: "fas fa-external-link-alt text-sm ml-1"
        "view#{i_tag}".html_safe
      end
    end

    def unit_subtotal
      number_with_delimiter(prepared_tranzaction.unit_subtotal)
    end

    def amount_subtotal
      number_to_currency(prepared_tranzaction.amount_subtotal)
    end

    def fee_subtotal
      number_to_currency(prepared_tranzaction.fee_subtotal)
    end

    def row_color
      condition = prepared_tranzaction_counter % 2 == 0
      condition ? ROW_COLOR[:even] : ROW_COLOR[:odd]
    end
  end
end
