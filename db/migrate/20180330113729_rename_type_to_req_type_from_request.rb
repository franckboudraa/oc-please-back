class RenameTypeToReqTypeFromRequest < ActiveRecord::Migration[5.1]
  def change
    rename_column :requests, :type, :reqtype
  end
end
