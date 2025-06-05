class CreateSolidQueueTables < ActiveRecord::Migration[7.1]
  def change
    create_table :solid_queue_jobs do |t|
      t.string :queue_name, null: false
      t.string :job_class, null: false
      t.text :arguments
      t.timestamp :scheduled_at
      t.timestamp :finished_at
      t.timestamp :expired_at
      t.integer :attempts, null: false, default: 0
      t.string :last_error
      t.timestamps
    end

    create_table :solid_queue_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.timestamp :started_at
      t.timestamp :finished_at
      t.string :status
      t.timestamps
    end

    add_index :solid_queue_jobs, :queue_name
    add_index :solid_queue_jobs, :scheduled_at
  end
end
