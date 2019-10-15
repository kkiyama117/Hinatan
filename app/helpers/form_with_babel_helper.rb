# frozen_string_literal: true

# Form helper
module FormWithBabelHelper
  def form_field_with(form, attr_hash, field, field_class: 'input', help_text: nil, &block)
    tmp = if block_given?
            block
          elsif field.present? && attr_hash.present?
            (tag.div class: 'control' do
              form.send(field.to_sym, attr_hash, class: field_class)
            end)
          end
    tag.div(
      (form.label attr_hash, class: 'label') + tmp +
          (tag.p help_text, class: 'help' if help_text),
      class: 'field'
    )
  end
end
