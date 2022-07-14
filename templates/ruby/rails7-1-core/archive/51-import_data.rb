# frozen_string_literal: true

require_relative "import_data_run_all"
require_relative "import_data_reset_all"

Dir["db/import_data/import_table/*.rb"].each { |file| load file }

# Imports seed or sample data into the database
class ImportData
  include ImportTable
  include ImportDataRunAll
  include ImportDataResetAll

  def initialize(is_sample)
    @is_sample = is_sample
  end

  def run
    puts "----------------------------------------------------------------------"
    puts "SeedRunner Started"
    puts "is_sample: #{@is_sample}"
    puts "----------------------------------------------------------------------"

    run_all
  end

  def full_file(table_name)
    if @is_sample
      Rails.root.join("db", "data", "sample", table_name)
    else
      Rails.root.join("db", "data", "seed", table_name)
    end
  end

  def open(table)
    file = full_file(table)

    if File.file?(file)
      open_yaml_file(file)
    else
      []
    end
  end

  def open_yaml_file(full_file_name)
    # puts "Seeding file #{full_file_name}"

    result = []

    File.open(full_file_name) do |file|
      doc = YAML.safe_load(file)

      return result unless doc

      doc.keys.sort.each do |key|
        result.push(doc[key])
      end
    end

    result
  end
end
