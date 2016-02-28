class CreateRadios < ActiveRecord::Migration[5.0]
  def change
    create_table :radios do |t|
      t.string :name
      t.string :uri

      t.timestamps
    end
  end
end
