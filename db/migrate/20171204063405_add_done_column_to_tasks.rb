class AddDoneColumnToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :is_done, :boolean, default: false
  end
end
