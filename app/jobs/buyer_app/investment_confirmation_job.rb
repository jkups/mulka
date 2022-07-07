module BuyerApp
  class InvestmentConfirmationJob < ApplicationJob
    include ActiveSupport::NumberHelper

    def perform(tranzaction_id:)
      tranzaction = Tranzactions::Tranzaction.find_by(id: tranzaction_id)
      template = Services::Email::Templates::InvestmentConfirmation.new(
        to: fetch_to(tranzaction),
        name: fetch_name(tranzaction),
        subject: build_subject(tranzaction)
      )

      init_client.send_mail(template)
    end

    private

    def init_client
      Services::Email::Client.new
    end

    def fetch_to(tranzaction)
      tranzaction.portfolio.buyer.email
    end

    def fetch_name(tranzaction)
      tranzaction.portfolio.buyer.full_name
    end

    def build_subject(tranzaction)
      total_invested_amount = tranzaction.amount + tranzaction.fee
      formatted_amount = number_to_currency(total_invested_amount)
      "Invesment Confirmation (#{formatted_amount})"
    end
  end
end
