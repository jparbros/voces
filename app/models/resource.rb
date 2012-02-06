class Resource < ActiveRecord::Base

  #
  # Associatons
  #
  belongs_to :resoursable, :polymorphic => true

end
