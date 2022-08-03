module UseCases
  module SellerApp
    module Properties
      class Create
        include DryCases::Mixin

        map :accumulator
        map :build_property
        map :build_property_feature
        check :valid?
        around :db_transaction, with: "db_transaction" # execute subsequent steps in a transaction
        step :persist_property
        step :persist_property_feature

        Accumulator = Struct.new(:form, :property, :property_feature, keyword_init: true)

        private

        def accumulator(form)
          Accumulator.new(form: form)
        end

        def valid?(accumulator)
          accumulator.form.valid?
        end

        def build_property(accumulator)
          form = accumulator.form

          property = ::Properties::Property.new(
            pid: form.pid,
            name: form.name,
            images: form.images,
            occupied: form.occupied,
            description: form.description,
            category: form.category,
            classification: form.classification,
            address: form.address,
            suburb: form.suburb,
            subdivision: form.subdivision,
            country_code: form.country_code,
            owner: form.owner,
            organization: form.organization
          )

          Accumulator.new(**accumulator.to_h, property: property)
        end

        def build_property_feature(accumulator)
          form = accumulator.form

          property_feature = ::Properties::PropertyFeature.new(
            bed: form.bed,
            bath: form.bath,
            parking: form.parking,
            floor_size: form.floor_size,
            plot_size: form.plot_size,
            property: accumulator.property
          )

          Accumulator.new(**accumulator.to_h, property_feature: property_feature)
        end

        def persist_property(accumulator)
          accumulator.property.save ? Success(accumulator) : Failure(accumulator.form)
        end

        def persist_property_feature(accumulator)
          accumulator.property_feature.save ? Success(accumulator.property) : Failure(accumulator.form)
        end
      end
    end
  end
end
