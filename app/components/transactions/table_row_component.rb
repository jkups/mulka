module Transactions
  class TableRowComponent < ViewComponent::Base
    THUMBNAIL_SIZE = {width: 80}.freeze
    ROW_COLOR = {odd: "bg-white", even: "bg-gray-100"}.freeze
    private_constant :THUMBNAIL_SIZE, :ROW_COLOR

    with_collection_parameter :prepared_transaction

    def initialize(prepared_transaction:, prepared_transaction_counter:)
      @prepared_transaction = prepared_transaction
      @prepared_transaction_counter = prepared_transaction_counter
    end

    private

    attr_reader :prepared_transaction, :prepared_transaction_counter

    def toggle_transactions_button
      content_tag(
        :span,
        class: "px-2 mr-4 cursor-pointer transform",
        data: {action: "click->toggle-transactions#toggle", id: property_id}
      ) { tag.i class: "fas fa-chevron-down text-base text-green-500" }
    end

    def property_thumbnail
      cl_image_tag(
        prepared_transaction.property_image,
        width: THUMBNAIL_SIZE[:width],
        crop: "fill"
      )
    end

    def property_id
      prepared_transaction.property_id
    end

    def property_name
      content_tag(:a, href: property_path(property_id), target: "_blank") do
        i_tag = tag.i class: "fas fa-external-link-alt text-sm ml-1"
        "#{prepared_transaction.property_name}#{i_tag}".html_safe
      end
    end

    def unit_subtotal
      number_with_delimiter(prepared_transaction.unit_subtotal)
    end

    def value_subtotal
      number_to_currency(prepared_transaction.value_subtotal)
    end

    def fee_subtotal
      number_to_currency(prepared_transaction.fee_subtotal)
    end

    def row_color
      condition = prepared_transaction_counter % 2 == 0
      condition ? ROW_COLOR[:even] : ROW_COLOR[:odd]
    end
  end
end
