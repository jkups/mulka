module Properties
  class FeatureComponent < ViewComponent::Base
    def initialize(feature:)
      @feature = feature
    end

    private

    attr_reader :feature

    def bed
      i_tag = tag.i class: "fas fa-bed mx-0.5"
      "#{feature.bed_count} #{i_tag}".html_safe
    end

    def bath
      i_tag = tag.i class: "fas fa-bath mx-0.5"
      "#{feature.bath_count} #{i_tag}".html_safe
    end

    def carpark
      i_tag = tag.i class: "fas fa-car mx-0.5"
      "#{feature.carpark} #{i_tag}".html_safe
    end

    def plot_size
      "#{feature.plot_size} sqft"
    end
  end
end
