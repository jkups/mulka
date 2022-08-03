module Services
  module Google
    class MapsApi
      def self.generate_url(key: ENV["GOOGLE_PLACES_API_KEY"], libraries: [], callback: nil)
        libraries_string = libraries.join(",")

        Addressable::Template.new(
          "https://maps.googleapis.com/maps/api/js{?key,libraries,callback}"
        ).partial_expand({
          key: key,
          libraries: libraries_string,
          callback: callback
        }).pattern
      end
    end
  end
end
