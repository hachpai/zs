class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :society
      t.string :societyType
      t.string :url
      t.string :description
      t.integer :category
      t.timestamps
    end
  end
end
