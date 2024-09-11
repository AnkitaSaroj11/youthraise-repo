class RenameTemplateableFieldsOnPersonalMessages < ActiveRecord::Migration[7.0]
  def change
    rename_column :personal_messages, :templateable_id, :messageable_id
    rename_column :personal_messages, :templateable_type, :messageable_type
  end
end
