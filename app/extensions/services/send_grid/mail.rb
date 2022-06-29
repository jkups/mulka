module Services
  module SendGrid
    class Mail
      class << self
        def call(template:)
          new(
            template: template,
            mail: ::SendGrid::Mail.new
          ).template_to_mail
        end
      end

      private

      attr_reader :mail, :personalization, :template

      def initialize(mail:, template:)
        @template = template
        @mail = mail
        @personalization = Personalization.new
      end

      def template_to_mail
        set_mail_to
        set_mail_subject
        set_mail_template_data
        set_mail_template_id
        set_mail_personalization

        mail
      end

      def set_mail_template_data
        personalization.add_dynamic_template_data(template.data)
      end

      def set_mail_template_id
        mail.template_id = template.identifier
      end

      def set_mail_subject
        personalization.subject = template.subject
      end

      def set_mail_to
        personalization.add_to(
          Email.new(email: template.to, name: template.name)
        )
      end

      def set_mail_personalization
        mail.add_personalization(personlaization)
      end
    end
  end
end
