class PaymentProcessingModalComponent < ViewComponent::Base
  delegate :render_svg, to: :helpers

  def initialize
  end
end
