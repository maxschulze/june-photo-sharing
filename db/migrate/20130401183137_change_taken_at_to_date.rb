class ChangeTakenAtToDate < ActiveRecord::Migration
  def up
    change_column :photos, :taken_at, :date
  end

  def down
    change_column :photos, :taken_at, :datetime
  end
end