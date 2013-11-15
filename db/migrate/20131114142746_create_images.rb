class CreateImages < ActiveRecord::Migration
def change
  create_table :images do |t|
#    t.integer :attachable_id
#    t.string :attachable_type
    t.references :attachable, polymorphic: true
    t.timestamps
    t.has_attached_file :asset
 end
end
end
