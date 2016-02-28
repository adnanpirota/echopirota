class AddRadioToMatch < ActiveRecord::Migration[5.0]
  def change
    add_reference :matches, :radio, foreign_key: true
  end
end
