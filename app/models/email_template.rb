class EmailTemplate < ApplicationRecord
  belongs_to :templateable, polymorphic: true

  has_rich_text :email
end
