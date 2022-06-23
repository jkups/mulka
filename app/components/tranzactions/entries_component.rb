module Tranzactions
  class EntriesComponent < ViewComponent::Base
    DATE_FORMAT = "%d/%m/%Y".freeze
    PAYMENT_METHOD_ICONS = {
      paypal: "fab fa-paypal",
      card: "fas fa-credit-card"
    }.freeze

    private_constant :DATE_FORMAT, :PAYMENT_METHOD_ICONS

    with_collection_parameter :tranzaction_entry

    def initialize(tranzaction_entry:)
      @tranzaction_entry = tranzaction_entry
    end

    private

    attr_reader :tranzaction_entry
    def tranzaction_id
      tranzaction_entry.id
    end

    def tranzaction_date
      tranzaction_entry.created_at.strftime(DATE_FORMAT)
    end

    def tranzaction_number
      tranzaction_entry.external_reference.referenceable_id.upcase
    end

    def payment_method
      tranzaction_entry.external_reference.referenceable_source
    end

    def payment_method_icon
      icon = PAYMENT_METHOD_ICONS[payment_method.to_sym]
      tag.i class: icon
    end

    def value_subtotal
      number_to_currency(tranzaction_entry.amount)
    end

    def fee_subtotal
      number_to_currency(tranzaction_entry.fee)
    end

    def units_acquired
      number_with_delimiter(tranzaction_entry.units)
    end
  end
end
