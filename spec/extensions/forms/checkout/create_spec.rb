require "rails_helper"

RSpec.describe Forms::Checkout::Create, type: :form do
  subject(:form) { described_class.from_params(params: params, user: user) }
  let(:params) { {property_id: property.id} }
  let(:property) { create(:property, name: "Dream House", listing_price: 54000, minimum_units: 2, available_units: 350, total_units: 1000) }
  let(:user) { create(:user) }

  it "creates a form object" do
    expect(form.property_id).to eql property.id
    expect(form.user_id).to eql user.id
    expect(form.name).to eql "Dream House"
    expect(form.listing_price).to eql 54000
    expect(form.number_of_units).to eql 2
    expect(form.available_units).to eql 350
    expect(form.total_units).to eql 1000
  end

  context "number of units is set" do
    let(:params) { {property_id: property.id, property: {number_of_units: 10}} }

    it "creates a form object with the correct number of units" do
      expect(form.number_of_units).to eql 10
    end
  end

  context "nonce and number of units is set" do
    let(:params) { {property_id: property.id, property: {number_of_units: 20, nonce: "234454"}} }

    it "creates a form object with the correct number of units" do
      expect(form.number_of_units).to eql 20
      expect(form.nonce).to eql "234454"
    end
  end
end
