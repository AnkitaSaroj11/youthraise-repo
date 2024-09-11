class Organization < ApplicationRecord
  has_many :campaigns, dependent: :destroy

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [64, 64]
    attachable.variant :small, resize_to_limit: [128, 128]
  end

end
