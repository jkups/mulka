require "rails_helper"

RSpec.describe UseCases::Transactions::Update, type: :usecase do
  subject(:result) { described_class.call(data) }
  let(:data) { {transaction_id: transaction.id} }
  let(:transaction) { create(:transaction, units: 10, property: property) }
  let(:property) { create(:property, available_units: 1000) }

  it "updates transaction status" do
    expect(result).to be_success
    expect(result.value!.status).to eql "confirmed"
  end

  it "reduces property available units" do
    expect { result }.to change { Property.find(property.id).available_units }.from(1000).to(990)
  end
end
