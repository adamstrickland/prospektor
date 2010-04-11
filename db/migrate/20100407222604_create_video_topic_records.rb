class CreateVideoTopicRecords < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      InformationTopic.all.each do |i|
        if i.information.index('video') and not Video.find_by_name(i.name)
          v = Video.new
          v.name = i.name
          v.url = i.information
          v.on_complete_hook = '/public/bcr?key=<%= @key %>' if i.name == 'Business Condition Review'
          v.save!
          i.delete
        end
      end
    
      Video.all.each do |v|
        vt = VideoTopic.new
        vt.name = v.name
        vt.video = v
        vt.save!
      end
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      VideoTopic.all.each do |vt|
        i = InformationTopic.new
        i.name = vt.name
        i.information = vt.video.url
        i.save
      end
      
      VideoTopic.delete_all
    end
  end
end
