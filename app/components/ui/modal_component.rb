module Ui
  class ModalComponent < ViewComponent::Base
    def initialize(id:, hidden: true)
      @id = id
      @hidden = hidden
    end

    private

    attr_reader :id, :hidden

    def hide_modal
      "hidden" if hidden
    end
  end
end
