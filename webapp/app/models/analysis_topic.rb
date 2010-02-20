class AnalysisTopic < Topic
  # table_name :topics
  has_many :appointments
  validates_presence_of :number
  validates_uniqueness_of :number
end
