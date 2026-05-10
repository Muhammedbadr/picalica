class RemoveContentFromVideos < ActiveRecord::Migration[8.1]
  def change
    remove_column :videos, :content, :text
  end
end
