# frozen_string_literal: true

require "active_support"
require "active_support/core_ext" # Required for self.blank? SEE: https://github.com/rails/rails/issues/14664

# Extension methods to string
class String
  # Is a string holding an integer
  # rubocop:disable Naming/PredicateName:
  def is_i?
    !!(self =~ /^[-+]?[0-9]+$/)
  end

  def is_uuid4?
    # check for a long version of the uuid, including the optional uri prefix
    !!(self =~ /^(urn:)?[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}$/i ||
        # or a short (compact) version
        self =~ /^[a-f0-9]{12}4[a-f0-9]{3}[89aAbB][a-f0-9]{15}$/i)
  end

  # Case insensitive equality check
  def is_equal?(value)
    # PL.info("testing" + value)
    casecmp(value).zero?
  end
  # rubocop:enable Naming/PredicateName:

  # Convert a string to true/false
  #
  # SEE: http://drawingablank.me/blog/ruby-boolean-typecasting.html
  def to_bool(default: false)
    return true if self == true || self =~ (/^(true|t|yes|y|1)$/i)
    return false if self == false || blank? || self =~ (/^(false|f|no|n|0)$/i)

    default
    # raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end

  def parse_json(default: {})
    nil? ? default : JSON.parse(self)
  end

  # ----------------------------------------------------------------------
  # Colorize your strings for console output
  # ----------------------------------------------------------------------

  def black
    "\033[30m#{self}\033[0m"
  end

  def red
    "\033[31m#{self}\033[0m"
  end

  def green
    "\033[32m#{self}\033[0m"
  end

  def brown
    "\033[33m#{self}\033[0m"
  end

  def blue
    "\033[34m#{self}\033[0m"
  end

  def magenta
    "\033[35m#{self}\033[0m"
  end

  def cyan
    "\033[36m#{self}\033[0m"
  end

  def grey
    "\033[37m#{self}\033[0m"
  end

  def default
    "\033[39m#{self}\033[0m"
  end

  def bg_black
    "\033[40m#{self}\033[0m"
  end

  def bg_red
    "\033[41m#{self}\033[0m"
  end

  def bg_green
    "\033[42m#{self}\033[0m"
  end

  def bg_brown
    "\033[43m#{self}\033[0m"
  end

  def bg_blue
    "\033[44m#{self}\033[0m"
  end

  def bg_magenta
    "\033[45m#{self}\033[0m"
  end

  def bg_cyan
    "\033[46m#{self}\033[0m"
  end

  def bg_grey
    "\033[47m#{self}\033[0m"
  end

  def bg_default
    "\033[49m#{self}\033[0m"
  end

  def bold
    "\033[1m#{self}\033[22m"
  end

  def reverse_color
    "\033[7m#{self}\033[27m"
  end

  def uncolorize
    gsub(/\e\[(\d+)m/, "")
  end
end
