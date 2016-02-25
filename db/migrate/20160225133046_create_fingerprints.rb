class CreateFingerprints < ActiveRecord::Migration[5.0]
  def change
    create_table :fingerprints do |t|
      t.string :fingerprint

      t.timestamps
    end
  end
end
