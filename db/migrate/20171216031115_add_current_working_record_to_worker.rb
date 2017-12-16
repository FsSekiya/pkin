class AddCurrentWorkingRecordToWorker < ActiveRecord::Migration[5.1]
  def change
    add_reference :workers, :current_working_record, foreign_key: { to_table: :working_records }
  end
end
