class ChangeJsonFormatInSubmissions < ActiveRecord::Migration
   def up
    change_column :submissions, :videos, :string
  end

  def down
    change_column :submissions, :videos, :json
  end
end
