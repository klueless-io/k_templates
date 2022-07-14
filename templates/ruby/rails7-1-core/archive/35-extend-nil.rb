# frozen_string_literal: true

# Extension methods for nil
class NilClass
  def to_bool
    false
  end
end
