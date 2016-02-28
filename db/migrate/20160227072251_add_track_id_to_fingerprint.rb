class AddTrackIdToFingerprint < ActiveRecord::Migration[5.0]
  def change
    add_column :fingerprints, :track_id, :string
  end
end
