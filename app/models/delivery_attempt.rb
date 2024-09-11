class DeliveryAttempt < ApplicationRecord
  belongs_to :deliverable, polymorphic: true
end
