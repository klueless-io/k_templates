# frozen_string_literal: true

# NOTE: Maybe better of renaming this to DebugService

# Application Service, just useful some generic stuff
class AppService
  # Default spreadsheet name to use with GSheet Readers
  DEFAULT_SPREADSHEET_NAME = "{{camel settings.application}}"

  # Default spreadsheet name to use with GSheet Readers in unit tests
  DEFAULT_SPREADSHEET_NAME_TEST = "{{camel settings.application}}UnitTest"

  # Turn on logs that make sense for production
  CONSOLE_LOG_PRODUCTION = "production"

  # Turn off all on logs so that unit tests are clean
  CONSOLE_LOG_UNIT_TEST = "unit-test"

  # Turn on logs that make sense for debugging
  CONSOLE_LOG_DEBUG = "debug"

  # Turn on Test Data Printing, turn this off for full unit test coverage
  SHOULD_PRINT_TEST_DATA = true

  @log_type = CONSOLE_LOG_PRODUCTION

  def self.default_test_log_type
    default = 0 # Set to 0 when debugging, otherwise 1

    @log_type = CONSOLE_LOG_DEBUG         if default.zero?
    @log_type = CONSOLE_LOG_UNIT_TEST     if default == 1
  end

  def self.test_log_type(log_type)
    @log_type = log_type
  end

  # Production OR debug mode
  # NOT unit test mode as it is meant to be free of all logging
  def self.report_mode
    # Report mode is for production code, but also quiet handy during debugging
    AppService.production || AppService.debug
  end

  def self.production
    @log_type.is_equal?(CONSOLE_LOG_PRODUCTION)
  end

  def self.unit_test
    @log_type.is_equal?(CONSOLE_LOG_UNIT_TEST)
  end

  def self.debug
    @log_type.is_equal?(CONSOLE_LOG_DEBUG)
  end
end
