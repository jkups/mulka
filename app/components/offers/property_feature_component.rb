module Offers
  class PropertyFeatureComponent < ViewComponent::Base
    def initialize(feature:)
      @feature = feature
    end

    private

    attr_reader :feature

    def bed
      i_tag = tag.i class: "fas fa-bed mx-0.5"
      "#{feature.bed} #{i_tag}".html_safe
    end

    def bath
      i_tag = tag.i class: "fas fa-bath mx-0.5"
      "#{feature.bath} #{i_tag}".html_safe
    end

    def parking
      i_tag = tag.i class: "fas fa-car mx-0.5"
      "#{feature.parking} #{i_tag}".html_safe
    end

    def plot_size
      "#{feature.plot_size} sqft"
    end
  end
end
