class AddWorkCmdToWorkers < ActiveRecord::Migration
  def change
    add_column :workers, :work_cmd, :string
  end
end
