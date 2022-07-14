# frozen_string_literal: true

# puts "STEP: Initialize"

# todo-check with Chris about this, really want to access JSON attributes using native data
# ActiveRecord::Type.register(:jsonb, JsonbType, override: true)

require_relative "../version"

# Extend base ruby classes
require_relative "../extend/extend_nil"
require_relative "../extend/extend_boolean"
require_relative "../extend/extend_string"

# Logging helpers, utilities and formatters
require_relative "../logger/log_helper"
require_relative "../logger/log_util"
require_relative "../logger/log_formatter"

# Constant for easy access to Rails logger
L = LogUtil.new(Rails.logger)
