class CreateVolunteers < ActiveRecord::Migration[5.1]
  def change
    create_table :volunteers do |t|
      t.references :request, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
