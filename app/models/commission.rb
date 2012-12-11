class Commission < ActiveRecord::Base
  
  #
  # Associations
  #
  has_and_belongs_to_many :initiatives
  
  #
  # Pagination
  #
  paginates_per 15
  
end
