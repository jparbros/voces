class Region < ActiveRecord::Base

  #
  # Associations
  #
  has_many :provinces
  has_many :representatives

  #
  # scopes
  #
  default_scope order('name asc')
end
