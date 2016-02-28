class AddTitleToFingerprint < ActiveRecord::Migration[5.0]
  def change
    add_column :fingerprints, :title, :string
  end
end
