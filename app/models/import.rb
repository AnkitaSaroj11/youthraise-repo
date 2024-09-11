class Import 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :file
  attr_accessor :activate_members

  validates :file, :presence => true

  def persisted?
    false
  end

end
