class CreateWorkerInformation < ActiveRecord::Migration[5.1]
  def change
    create_table :worker_informations do |t|
      t.string :title
      t.text :content
      t.datetime :published_date
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
