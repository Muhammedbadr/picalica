class AddLinkToVideos < ActiveRecord::Migration[8.1]
  def change
    add_column :videos, :link, :string
  end
end
