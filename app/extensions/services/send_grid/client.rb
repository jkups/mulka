module Services
  module SendGrid
    class Client
      def initialize(template:, config: SendGrid::Config.params)
        @client = ::SendGrid::API.new(**config).client
        @mail = SendGrid::Mail.call(template)
      end

      def send_mail
        client.mail._("send").post(request_body: mail.to_json)
      end

      private

      attr_reader :client, :mail
    end
  end
end
