class RepresentativeSearch

  attr_accessor :representatives

  def initialize(conditions = nil, page = 1)
    @representatives ||= find_representatives conditions, page
  end

  def find_representatives(conditions, current_page = 1)
    @representative_search = Representative
    if conditions
      find_by_name conditions[:name] if conditions[:name]
      find_by_state conditions[:state] if conditions[:state] && !conditions[:state].blank?
      find_by_political_party conditions[:political_party] if conditions[:political_party] && !conditions[:political_party].blank?
      find_by_commision(conditions[:commision]) if conditions[:commision]
      find_by_initial(conditions[:initial]) if conditions[:initial]
      find_by_topic(conditions[:topic]) if conditions[:topic]
    end
    @representative_search.page(current_page)
  end

  private

  def find_by_name(name)
    name.split(' ').each do |query|
      @representative_search = @representative_search.where('translate(representatives.first_name, "áéíóú", "aeiou") @@ :q OR translate(representatives.last_name, "áéíóú", "aeiou") @@ :q', q: query)
    end
  end

  def find_by_initial(initial)
    @representative_search = @representative_search.where('representatives.last_name iLike ?',"#{initial}%") if initial
  end

  def find_by_state state
    @representative_search = @representative_search.joins(:region).where('regions.id = ?', state) if state
  end

  def find_by_political_party political_party
    @representative_search = @representative_search.joins(:political_party).where('political_parties.id = ?', political_party) if political_party
  end

  def find_by_commision(commision_name)
    @representative_search = @representative_search.joins(:commissions).where('commissions.name = ?', commision_name) if commision_name
  end

  def find_by_topic(topic_name)
    @representative_search = @representative_search.joins(:topics).where('topics.name = ?', topic_name) if topic_name
  end

end