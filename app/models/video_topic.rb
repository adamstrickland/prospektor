class VideoTopic < Topic
  has_many :presentations
  belongs_to :video
  
  validates_presence_of :video
  
  def url
    self.video.url
  end
end
