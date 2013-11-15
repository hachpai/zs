class AddLogoToProjects < ActiveRecord::Migration
  def change
    change_table(:projects) do |t|
      t.has_attached_file :logo
    end
  end
end
