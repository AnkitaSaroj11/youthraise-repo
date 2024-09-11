class PersonalMessage < ApplicationRecord
  belongs_to :messageable, polymorphic: true
end
