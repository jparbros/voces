class Comment < ActiveRecord::Base

  #
  # Associations
  #
  belongs_to :commentable, :polymorphic => true, :counter_cache => true


  #
  # Scopes
  #
  scope :approved, where(:approved => true)
  scope :favor, where(:tendency => 1)
  scope :against, where(:tendency => -1)
  default_scope where(:spam => false)

  #
  # Validations
  #
  validates :author, :presence => true
  validates :comment, :presence => true

  #
  # Callbacks
  #
  # after_create :publish, :send_email

  #
  # Extends
  #
  include Defender::Spammable
  configure_defender :keys => { content: :comment }

  def self.create_approved(comment)
    self.create(comment.merge({:approved => true}))
  end

  def publish
    publisher = Publisher.new(self.comment)
    publisher.publish unless self.spam?
  end

  def send_email
    Comentario.send_email(self.author, self).deliver if self.commentable_type == 'Representative' && !self.spam?
  end

  def replies
    Comment.where("reply_to IS NOT NULL AND reply_to = ?", id)
  end

  def defensio_is_spam
    if defensio_sig.nil?
      data = {}
      data.merge!({
        'platform' => 'ruby',
        'type' => (Defender.test_mode ? 'test' : 'comment'),
        'document' => self.comment
        })
      document = Defender.defensio.post_document(data).last
      self.spam = !document['allow']
      self.defensio_sig = document['signature'].to_s
      self.spaminess = document['spaminess'] if self.respond_to?(:spaminess=)
      save
    end
  end
end
