# frozen_string_literal: true

# Format input control for readonly view
class ReadonlyInput < Formtastic::Inputs::StringInput
  def to_html
    input_wrapping do
      label_html << template.pretty_format(object.send(method))
    end
  end
end
