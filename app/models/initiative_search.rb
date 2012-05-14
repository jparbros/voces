class InitiativeSearch

  attr_accessor :initiatives

  def initialize(conditions = nil, page = 1)
    @initiatives ||= find_initiatives conditions, page
  end

  def find_initiatives(conditions, current_page)
    @initiative_search = Initiative
    if conditions
      find_by_title conditions[:title] if conditions[:title]
      find_by_description conditions[:description] if conditions[:description]
      find_by_topic_name conditions[:topic_name] if conditions[:topic_name]
      find_by_representative conditions[:representative] if conditions[:representative]
      find_by_keywords conditions[:keywords] if conditions[:keywords]
      find_by_region conditions[:estado] if conditions[:estado]
      find_by_political_party conditions[:political_party] if conditions[:political_party]
      find_by_date conditions[:mes], conditions[:ano]  if conditions[:mes] and conditions[:ano]
    end
    @initiative_search.page(current_page)
  end

  private

  def find_by_title(title_to_find)
    @initiative_search = @initiative_search.where('title @@ :q', q: title_to_find) if title_to_find
  end

  def find_by_description(description_to_find)
    @initiative_search = @initiative_search.where('description @@ :q', q: description_to_find) if description_to_find
  end

  def find_by_topic_name topic_name
    @initiative_search = @initiative_search.joins(:topics).where('topics.name @@ :q', q: topic_name) if topic_name
  end

  def find_by_representative representative_name
    representative_name.split(' ').each do |query|
      @initiative_search = @initiative_search.includes(:representative).where('representatives.first_name @@ :q OR representatives.last_name @@ :q', q: query) if representative_name
    end
  end

  def find_by_keywords keywords
    keywords.split(' ').each do |query|
       @initiative_search = @initiative_search.joins(:representative).joins(:topics).where('initiatives.title @@ :q OR initiatives.description @@ :q OR representatives.first_name @@ :q OR representatives.last_name @@ :q OR topics.name @@ :q', q: query)
    end
  end

  def find_by_region(region_name)
    @initiative_search = @initiative_search.joins(:representative => :region).where('regions.name @@ :q', q: region_name) if region_name
  end

  def find_by_political_party(political_party_name)
    @initiative_search = @initiative_search.joins(:representative => :political_party).where('political_parties.name @@ :q', q: political_party_name) if political_party_name
  end

  def find_by_date(month, year)
    @initiative_search = @initiative_search.where('presented_at BETWEEN ? AND ?',
      Time.new(year, month).beginning_of_month,
      Time.new(year, month).end_of_month
    ) if month and year
  end
end