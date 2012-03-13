class PoliticalParty < ActiveRecord::Base

  #
  # Associations
  #
  has_many :representatives

  #
  # Uploader
  #
  mount_uploader :logo, LogoUploader

  #
  # Scope
  #
  default_scope order('name ASC')

  def initials
    name.split(' ').collect {|word| word.first.downcase}.join('') if name
  end
end
