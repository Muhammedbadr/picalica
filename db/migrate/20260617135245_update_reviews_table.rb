class UpdateReviewsTable < ActiveRecord::Migration[8.1]
  def change
    # Remove the old, single rating column
    remove_column :reviews, :rating, :integer

    # Add the four specific rating columns
    change_table :reviews do |t|
      t.integer :work_quality
      t.integer :communication
      t.integer :ease_of_use
      t.integer :documentation_quality
    end
  end
end