class AddBlogoTypePosts < ActiveRecord::Migration
  def change
    posts_table = "#{Blogo.table_name_prefix}posts"

    add_column posts_table, :type, :string
  end
end
