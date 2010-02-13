class InformationTopic < Topic
  # table_name :topics
  has_many :presentations
  validates_presence_of :information
  # alias_method :url, :informationx
  alias_attribute :url, :information
end