class Topic < ActiveRecord::Base
  
  has_and_belongs_to_many :initiatives
  
  #
  # Validations
  #
  validates :name, :presence => true, :uniqueness => true
end
