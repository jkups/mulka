module BuyerApp
  class FormBuilder < ActionView::Helpers::FormBuilder
    def field_errors(method)
      return if object.errors[method].blank?
      @template.content_tag(:span, "#{object.errors[method].to_sentence.downcase.capitalize}.", class: "form-errors")
    end

    def label(method, text = nil, options = {}, &block)
      options[:class] = ["form-label", options[:class]]
      super(method, text, options, &block)
    end

    def text_field(method, options = {})
      options[:class] = ["form-input", options[:class]]
      super(method, options)
    end

    def email_field(method, options = {})
      options[:class] = ["form-input", options[:class]]
      super(method, options)
    end

    def password_field(method, options = {})
      options[:class] = ["form-input", options[:class]]
      super(method, options)
    end
  end
end
