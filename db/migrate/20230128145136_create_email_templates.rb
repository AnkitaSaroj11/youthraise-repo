class CreateEmailTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :email_templates do |t|
      t.string :subject
      t.text :body
      t.text :prompt
      t.integer :owner_id
      t.string :owner_type
      t.json :bot_response

      t.timestamps
    end
    add_index :email_templates, :owner_id
    add_index :email_templates, :owner_type
  end
end
