class AddUderIdToSchool < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :user_id, :integer
  end
end
