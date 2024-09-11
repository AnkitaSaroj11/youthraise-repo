class MakeDaveBoss < ActiveRecord::Migration[7.0]
  def change
    u = User.where(email: 'dave@trooptrack.com').first
    unless u.nil?
      u.youthraise_admin = true
      u.save!
    end
  end
end
