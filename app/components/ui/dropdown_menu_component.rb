module Ui
  class DropdownMenuComponent < ViewComponent::Base
    include ViewComponent::PolymorphicSlots

    renders_one :title, types: {
      icon: lambda do |text:, icon:|
        content = content_tag(:span, text)
        content << tag.i(class: [icon, "ml-2 text-sm"])
      end
    }

    renders_many :menu_items, ->(text:, path:, **options) do
      content_tag(:li,
        link_to(text, path, class: "p-2 px-4 inline-block", **options),
        class: "hover:text-green-500 cursor pointer"
      )
    end
  end
end
