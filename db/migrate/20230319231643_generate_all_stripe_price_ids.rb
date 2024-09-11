class GenerateAllStripePriceIds < ActiveRecord::Migration[7.0]
  def up
    Campaign.all.each do |c|
      begin
        c.create_stripe_price
      rescue Exception => e
        p e.inspect
      end
    end
  end

  def down
  end
end
