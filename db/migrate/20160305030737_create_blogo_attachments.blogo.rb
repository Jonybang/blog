class CreateBlogoAttachments < ActiveRecord::Migration
  def change
    attachments_table = "#{Blogo.table_name_prefix}attachments"

    create_table attachments_table do |t|
      t.attachment :file
      t.belongs_to :project

      t.timestamps null: false
    end
  end
end
