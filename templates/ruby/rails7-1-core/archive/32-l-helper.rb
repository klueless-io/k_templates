# frozen_string_literal: true

# Log Helper is an internal class that takes care of a lot of the formatting of different content types
# e.g key/values, lines, progress counters and headings
# it is different to the formatter because the formatter is used by Rails Logger to change the output stream style and format
class LogHelper
  @progress_section = ""
  @progress_position = 0

  class << self
    attr_accessor :progress_position
    attr_accessor :progress_section
  end

  def self.kv(key, value, key_width = 30)
    "#{key.ljust(key_width).to_s.green}: #{value}"
  end

  def self.progress(pos = nil, section = nil)
    @progress_position = if pos.blank?
                           @progress_position
                         else
                           pos
                         end

    unless section.nil?
      # Pl.info "here"
      @progress_section = section
    end

    # puts "@progress_position"
    # puts @progress_position
    # puts "@progress_section"
    # puts @progress_section

    section_length = 28

    section = if @progress_section.blank?
                " " * section_length
              else
                " #{@progress_section.ljust(section_length - 1, ' ')}"
              end

    # puts "section"
    # puts section

    result = "..#{section}:#{@progress_position.to_s.rjust(4)}"

    @progress_position += 1

    result
  end

  def self.line(size = 70, character = "=")
    result = character * size
    result.green
  end

  def self.heading(heading, size = 70)
    line = line(size)

    [
      line,
      heading,
      line
    ]
  end

  def self.subheading(heading, size = 70)
    line = line(size, "-")
    [
      line,
      heading,
      line
    ]
  end

  # A section heading
  #
  # example:
  # [ I am a heading ]----------------------------------------------------
  def self.section_heading(heading, size = 70)
    heading = "[ #{heading} ]"
    line = line(size - heading.length, "-")

    # It is important that you set the colour after you have calculated the size
    "#{heading.green}#{line}"
  end

  # :sql_array should be an array with SQL and values
  # example: L.sql(["name = :name and group_id = :value OR parent_id = :value", name: "foo"bar", value: 4])
  def sql(sql_array)
    value = ActiveRecord::Base.send(:sanitize_sql_array, sql_array)

    info(value)
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def self.block(messages, include_line: true, title: nil)
    result = include_line ? [line] : []

    if title.present?
      result.push(title)
      result.push(line(70, ","))
    end

    result.push(messages) if messages.is_a?(String) || messages.is_a?(Integer)

    if messages.is_a? Array
      messages.each do |message|
        result.push message
      end
      # result = result + messages
    end

    result.push(line) if include_line

    result
  end
  # rubocop:enable Metrics/CyclomaticComplexity
end
