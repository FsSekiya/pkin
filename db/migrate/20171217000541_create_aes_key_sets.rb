class CreateAesKeySets < ActiveRecord::Migration[5.1]
  def change
    create_table :aes_key_sets do |t|
      t.string :key
      t.string :iv

      t.timestamps
    end
  end
end
