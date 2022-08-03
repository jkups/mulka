module Services
  module Cloudinary
    class UploadApi
      def self.signed_upload(organization:)
        organization_name = organization.name.downcase
        new(organization_name: organization_name).get_token
      end

      attr_reader :organization_name

      def initialize(organization_name:)
        @organization_name = organization_name
      end

      def get_token
        {
          cloudname: ENV["CLOUDINARY_NAME"],
          apikey: ENV["CLOUDINARY_API_KEY"],
          folder: organization_name,
          timestamp: timestamp,
          signature: signature
        }
      end

      private

      def signature
        ::Cloudinary::Utils.api_sign_request({
          timestamp: timestamp,
          folder: organization_name,
          use_filename: true
        }, ENV["CLOUDINARY_API_SECRET"])
      end

      def timestamp
        @current_time ||= Time.now.to_i
      end
    end
  end
end
