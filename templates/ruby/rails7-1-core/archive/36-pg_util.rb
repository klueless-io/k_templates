# frozen_string_literal: true

# Postgres Helper Util
class PgUtil
  def self.execute_sql_in_file(file, key_values = [])
    sql = [File.read(file)]
    #
    # # See: http://api.rubyonrails.org/classes/ActiveRecord/Sanitization/ClassMethods.html
    # sanitized_sql = ActiveRecord::Base.send(:sanitize_sql, [*sql, *key_values])

    execute_sql(sql, key_values)
  end

  # Example
  # PgService::execute_sql(sql, [starting_id: starting_id, count: count])
  def self.execute_sql(sql, key_values = [])
    # See: http://api.rubyonrails.org/classes/ActiveRecord/Sanitization/ClassMethods.html
    sanitized_sql = ActiveRecord::Base.send(:sanitize_sql, [*sql, *key_values])

    ActiveRecord::Base.connection.execute(sanitized_sql)
  end

  # Example
  # PgService::sanitize_sql(sql, [values: values])
  def self.sanitize_sql(sql, key_values = [])
    # See: http://api.rubyonrails.org/classes/ActiveRecord/Sanitization/ClassMethods.html
    Arel.sql(ActiveRecord::Base.send(:sanitize_sql, [*sql, *key_values]))
  end

  def self.index_list(table_name)
    # Sample data
    # {"table_name"=>"jobs", "index_name"=>"title"}
    # {"table_name"=>"jobs", "index_name"=>"id"}

    sql = <<-SQL
    SELECT t.relname as table_name, a.attname as index_name
    FROM pg_class t
         JOIN pg_index ix ON t.oid = ix.indrelid
         JOIN pg_class i ON i.oid = ix.indexrelid
         JOIN pg_attribute a ON a.attrelid = t.oid
    WHERE#{' '}
        a.attnum = ANY(ix.indkey)#{' '}
      AND 	t.relkind = 'r'#{' '}
      AND 	t.relname = :table_name
      --AND	a.attname = 'key3'
    ORDER BY
         t.relname,
         i.relname;
    SQL

    sql = Arel.sql(sql)

    # See: http://api.rubyonrails.org/classes/ActiveRecord/Sanitization/ClassMethods.html
    sanitized_sql = ActiveRecord::Base.send(:sanitize_sql, [sql, { table_name: table_name }])

    ActiveRecord::Base.connection.execute(sanitized_sql).map { |row| row["index_name"] }
  end

  def self.index_exists(table_name, index_name)
    sql = <<-SQL
    SELECT count(*)
    FROM pg_class t
         JOIN pg_index ix ON t.oid = ix.indrelid
         JOIN pg_class i ON i.oid = ix.indexrelid
         JOIN pg_attribute a ON a.attrelid = t.oid
    WHERE#{' '}
            a.attnum = ANY(ix.indkey)#{' '}
      AND 	t.relkind = 'r'#{' '}
      AND 	t.relname = :table_name
      AND	  a.attname = :index_name
    SQL

    sql = Arel.sql(sql)

    # See: http://api.rubyonrails.org/classes/ActiveRecord/Sanitization/ClassMethods.html
    sanitized_sql = ActiveRecord::Base.send(:sanitize_sql, [sql, { table_name: table_name, index_name: index_name }])

    ActiveRecord::Base.connection.execute(sanitized_sql).first["count"] == 1
  end

  # Ensure that the correct indexes are in place for the action you are attempting to run.
  #
  # Because of the huge amount of data, we need to have different index profiles in place depending on what we are doing.
  #
  # Job Import
  # Job Inference of roles, skills and other meta data
  # Job Querying
  def self.check_index_integrity(table_name, expected_indexes)
    indexes = PgService.index_list(table_name)

    result = indexes.count == expected_indexes.count

    unless result
      L.info("Indexes")
      L.block indexes

      L.info("Expected Indexes")
      L.block expected_indexes
    end

    # L.block indexes

    expected_indexes.each do |expected_index|
      result &&= indexes.include?(expected_index)

      L.kv "Missing Index", expected_index unless indexes.include?(expected_index)
    end

    result
  end
end
