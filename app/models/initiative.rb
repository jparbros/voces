# encoding: utf-8
class Initiative < ActiveRecord::Base
  #
  # Associations
  #
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_and_belongs_to_many :commissions
  has_many :votes
  has_many :official_votes
  has_many :resources, :as => :resoursable, :dependent => :destroy
  has_and_belongs_to_many :topics
  belongs_to :representative
  belongs_to :political_party

  #
  # Nested Attributes
  #
  accepts_nested_attributes_for :official_votes
  accepts_nested_attributes_for :resources

  #
  # Attributes
  #
  attr_reader :topic_tokens, :presented_by_token

  #
  # Scope
  #
  scope :main, where(:main => true)
  default_scope order('cast(number as int) ASC')

  #
  # Pagination
  #
  paginates_per 5

  #
  # States
  #
  STATES = {
    :commission => 'En comisión',
    :dictum => 'Dictamen',
    :debate_in_plenary => 'Debate en Pleno',
    :promulgation_and_enforcement => 'Promulgación y vigencia'
  }

  #
  # States Machine
  #
  state_machine :state, :initial => :commission do
    state :commission
    state :dictum
    state :debate_in_plenary
    state :promulgation_and_enforcement
  end

  def topic_tokens=(ids)
    self.topic_ids = ids.split(',')
  end

  def presented_by_token=(id)
    self.representative_id = id
  end

  def official_percentage_up
    p1 = (((official_vote_up.to_f*100)/total_official_votes))
    p1.nan? ? 0 : p1.round
  end

  def official_percentage_down
    p1 = ((official_vote_down.to_f*100)/total_official_votes)
    p1.nan? ? 0 : p1.round
  end

  def official_pixel_votes_up
    ((official_percentage_up.to_f/100)*383).to_i
  end

  def official_pixel_votes_down
    ((official_percentage_down.to_f/100)*383).to_i
  end

  def total_official_votes
    (official_vote_up || 0) + (official_vote_down || 0)
  end

  def official_voted?
    (official_vote_up || 0) > 0 && (official_vote_down || 0) > 0
  end

  def percentage_votes_up
    if votes_up > 0
      ((votes_up.to_f*100)/total_votes).round
    else
      0
    end
  end

  def percentage_votes_down
    if votes_down > 0
      ((votes_down.to_f*100)/total_votes).round
    else
      0
    end
  end

  def pixel_votes_up
    if votes_up > 0
      ((percentage_votes_up.to_f/100)*383).to_i
    else
      0
    end
  end

  def pixel_votes_down
    if votes_down > 0
      ((percentage_votes_down.to_f/100)*383).to_i
    else
      0
    end
  end

  def total_votes
    votes.count
  end

  def votes_up
    votes.votes_up.count
  end

  def votes_down
    votes.votes_down.count
  end

  def voted?
    votes_up > 0 || votes_down > 0
  end

  def state_formated
    STATES[state.to_sym]
  end

  def self.to_home
    initiative =  self.order('RANDOM()').limit(5)
    return self.main.first ? [self.main.first, initiative.first] : [initiative.first, initiative.last]
  end

  def presented?
    true
  end

  def commissioned?
    self.state != 'commission'
  end

  def plenaried?
    self.state == 'promulgation_and_enforcement' || self.state == 'debate_in_plenary'
  end

  def projected?
     self.state == 'promulgation_and_enforcement'
  end

  def official_votes_printable
    official_votes.where('votes > 0')
  end

  def official_votes_objects(create = false)
    if official_votes.empty?
      PoliticalParty.all.each do |political_party|
        official_vote = official_votes.build :political_party => political_party
        official_vote.save if create
      end
    end
  end
end
