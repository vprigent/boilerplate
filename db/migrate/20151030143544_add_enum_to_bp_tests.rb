class AddEnumToBpTests < ActiveRecord::Migration[5.0]
  def change
    add_column :bp_tests, :enum, :string
  end
end
