# frozen_string_literal: true

# Log formatter which only displays styled messages.
class LogFormatter < ::Logger::Formatter
  attr_accessor :show_caller

  def initialize(show_caller: false)
    @show_caller = show_caller
    super
  end

  SEVERITY_TO_COLOR_MAP = { "DEBUG" => "34", "INFO" => "32", "WARN" => "33", "ERROR" => "31", "FATAL" => "37" }.freeze

  # This method is invoked when a log event occurs
  # rubocop:disable Style/FormatStringToken, Style/FormatString
  def call(severity, _timestamp, _progname, msg)
    severity = severity.upcase

    color = SEVERITY_TO_COLOR_MAP[severity]

    severity_value = "\033[#{color}m%-5.5s\033[0m" % severity

    msg = msg.is_a?(String) ? msg : msg.inspect

    # callee = caller[4].split("/").last
    # callee = callee.split(":")[0,2].join(":")
    #
    # if callee.start_with?("logger") || callee.start_with?("log_")
    #   log_callee = ""
    #   log_callee = "[\033[01;36m#{callee}\033[0m]"
    # else
    #   log_callee = "[\033[01;36m#{callee}\033[0m]"
    # end

    if @show_caller
      # caller = "[\033[01;36m#{format_caller()}\033[0m]"

      caller = format_caller
      message = format("%-50s %s %s %s\n", caller, Time.now.strftime("%d|%H:%M:%S"), severity_value, msg)

    else
      message = format("%s %s %s\n", Time.now.strftime("%d|%H:%M:%S"), severity_value, msg)
    end

    message
  end
  # rubocop:enable Style/FormatStringToken, Style/FormatString

  # This is all a fudge for now, until I find a suitable solution
  # probably resolve with the semantic loggers
  def format_caller
    callee = ""

    caller.each do |item|
      next unless item.include?("xxx-server") && !item.include?("format_logger")

      callee = item.split("/").last
      callee = callee.split(":")[0, 2].join(":")
      break
    end

    callee
  end
end
