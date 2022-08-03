module UseCases
  module SellerApp
    module Properties
      class Update
        include DryCases::Mixin

        map :accumulator
        check :valid?
        around :db_transaction, with: "db_transaction" # execute subsequent steps in a transaction
        step :persist_property
        step :persist_property_feature

        Accumulator = Struct.new(:form, :property, :property_feature, keyword_init: true)

        private

        def accumulator(form)
          Accumulator.new(form: form, property: form.property, property_feature: form.property.property_feature)
        end

        def valid?(accumulator)
          accumulator.form.valid?
        end

        def persist_property(accumulator)
          form = accumulator.form

          property = accumulator.property.update(
            name: form.name,
            images: form.images,
            occupied: form.occupied,
            description: form.description,
            category: form.category,
            classification: form.classification,
            address: form.address,
            suburb: form.suburb,
            subdivision: form.subdivision,
            country_code: form.country_code
          )

          property ? Success(accumulator) : Failure(form)
        end

        def persist_property_feature(accumulator)
          form = accumulator.form

          property_feature = accumulator.property_feature.update(
            bed: form.bed,
            bath: form.bath,
            parking: form.parking,
            floor_size: form.floor_size,
            plot_size: form.plot_size,
            property: accumulator.property
          )

          property_feature ? Success(accumulator.property) : Failure(form)
        end
      end
    end
  end
end
