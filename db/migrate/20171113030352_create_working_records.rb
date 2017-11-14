class CreateWorkingRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :working_records do |t|
      t.references :worker, foreign_key: true
      t.datetime :start_at
      t.datetime :finish_at

      t.timestamps
    end
  end
end
