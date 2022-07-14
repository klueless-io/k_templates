# frozen_string_literal: true

# Extend the boolean TRUE class with some helper methods
class TrueClass
  def to_i
    1
  end

  def to_bool
    self
  end
end

# Extend the boolean FALSE class with some helper methods
class FalseClass
  def to_i
    0
  end

  def to_bool
    self
  end
end
