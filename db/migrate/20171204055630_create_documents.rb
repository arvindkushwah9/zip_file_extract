class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :name
      t.integer :user_id
      t.text :description

      t.timestamps
    end
  end
end
