class AddSequenceToBpTests < ActiveRecord::Migration[5.0]
  def change
    add_column :bp_tests, :sequence, :integer
  end
end
