class AddVideosToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :videos, :json
  end
end
