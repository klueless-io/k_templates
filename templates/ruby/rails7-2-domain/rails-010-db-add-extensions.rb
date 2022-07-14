# frozen_string_literal: true

# rails generate migration add_extensions
class AddExtensions < ActiveRecord::Migration[7.0]
  def up
    # NOTE: Add these when using postgres database
    # enable_extension("btree_gin")           unless extensions.include?("btree_gin")
    # enable_extension("hstore")              unless extensions.include?("hstore")
    # enable_extension("intarray")            unless extensions.include?("intarray")
    # enable_extension("pg_stat_statements")  unless extensions.include?("pg_stat_statements")
    # enable_extension("pg_trgm")             unless extensions.include?("pg_trgm")
  end
  
  def down
    # disable_extension("btree_gin")          if extensions.include?("btree_gin")
    # disable_extension("hstore")             if extensions.include?("hstore")
    # disable_extension("intarray")           if extensions.include?("intarray")
    # disable_extension("pg_stat_statements") if extensions.include?("pg_stat_statements")
    # disable_extension("pg_trgm")            if extensions.include?("pg_trgm")
  end
end
