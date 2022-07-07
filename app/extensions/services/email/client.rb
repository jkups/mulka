module Services
  module Email
    class Client
      def initialize(config: Email::Config.params)
        @client = SendGrid::API.new(**config).client
      end

      def send_mail(template)
        response = client.mail._("send").post(request_body: mail(template))
        Rails.logger.info(response.status_code)
        Rails.logger.info(response.body)
      end

      private

      attr_reader :client

      def mail(template)
        Email::TemplateMail.call(template).to_json
      end
    end
  end
end
