require "rails_helper"

RSpec.describe UseCases::Transactions::Create, type: :usecase do
  subject(:result) { described_class.call(form) }
  let(:form) { Forms::Checkout::Create.from_params(params: params, user: user) }
  let(:params) { {property_id: property.id, property: {number_of_units: 20, nonce: "thb5HeL-0__234454"}} }
  let(:property) { create(:property, name: "Dream House", listing_price: 54000, minimum_units: 2, available_units: 350, total_units: 1000) }
  let(:user) { create(:user) }

  before {
    allow(Braintree::ProcessPaymentJob).to receive(:perform_later) { true }
  }

  it "creates a transaction with the form data" do
    expect { result }.to change { Transaction.count }.from(0).to(1)
    expect(result).to be_success
  end

  it "calls a worker to process payment" do
    expect(Braintree::ProcessPaymentJob)
      .to(receive(:perform_later).with(
        transaction_id: anything,
        nonce: anything
      ))
    result
  end
end
