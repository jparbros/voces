class Representative < ActiveRecord::Base

  #
  # Associatons
  #
  belongs_to :region
  belongs_to :province
  belongs_to :political_party
  has_and_belongs_to_many :commissions
  has_and_belongs_to_many :topics
  has_many :initiatives
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :representation_actions

  #
  # Nested attributes
  #
  accepts_nested_attributes_for :representation_actions

  #
  # Accessor
  #
  attr_reader :commission_tokens, :topic_tokens
  attr_accessor :name

  #
  # Uploader
  #
  mount_uploader :avatar, AvatarUploader

  #
  # Pagination
  #
  paginates_per 500

  #
  # scopes
  #
  scope :by_region, lambda {|region_id| where(:region_id => region_id)}
  scope :by_commission, lambda {|commission_id| joins(:commissions).where('commissions_representatives.commission_id = ?', commission_id)}
  scope :most_commented, order('comments_count DESC')
  scope :monitoreados, where(following: true)

  #
  # Delegates
  #
  delegate :name, :to => :region, :prefix => true

  def commission_tokens=(ids)
    self.commission_ids = ids.split(',')
  end

  def topic_tokens=(ids)
    self.topic_ids = ids.split(',')
  end

  def as_json(options)
    super(options.merge({:methods => :name}))
  end

  def name
    "#{first_name} #{last_name}"
  end

  def photo(size = nil)
    return self.avatar.url(size) unless self.avatar.url.include? 'txt'
    unless size
      'front/missing.png'
    else
      'front/thumb_missing.png'
    end
  end
  
  def twitter_name
    twitter.gsub("@","")
  end
end
