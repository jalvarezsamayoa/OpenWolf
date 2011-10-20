class CreateWorkerLogs < ActiveRecord::Migration
  def self.up
  
    create_table :worker_logs, :force => true do |t|
      t.text :status
      t.integer :process_id
      t.text :last_error

      t.timestamps
    end
  
  end

  def self.down
    drop_table :worker_logs
  end
end
