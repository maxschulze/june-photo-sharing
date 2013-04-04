class ChangeTakenAtToDateTime < ActiveRecord::Migration
  def up
    change_column :photos, :taken_at, :datetime
  end

  def down
    change_column :photos, :taken_at, :date
  end
end