class MigrateScheduleData < ActiveRecord::Migration

  class NewAppointment < ActiveRecord::Base
    set_table_name 'appointments'
    belongs_to :lead
    belongs_to :user
    belongs_to :status, :class_name => 'AppointmentStatus'
  end

  def self.up
    #import data from schedules
    MigrateScheduleData::NewAppointment.reset_column_information
  
    Schedule.all.each do |s|
      a = MigrateScheduleData::NewAppointment.new
      a.id = s.id
      a.lead = s.contact.lead
      a.user = s.employee.user || User.find_by_login('gniblack')
      a.status = s.status
      a.scheduled_at = if s.cb_date
        if s.cb_time
          t = s.cb_time.strftime('%H:%M')
          d = s.cb_date.strftime('%Y-%m-%d')
          Chronic.parse("#{d} #{t}")
        else
          s.cb_date
        end
      end
      a.sale_probability = s.sale_probability if s.sale_probability.present?
      a.no_sale_reason = s.no_sale_reason
      a.references_requested = (s.references_requested.present? and s.references_requested.strip == '1')
      (1..3).each do |i|
        a.send("problem_#{i}=".to_sym, s.send("problem#{i}")) if s.send("problem#{i}")
        a.send("impact_#{i}=".to_sym, s.send("impact#{i}").to_i) if s.send("impact#{i}")
      end
      a.comments = s.comments
      a.created_at = Chronic.parse(s.entered) if s.entered.present?
      a.save
    end
  end

  def self.down
    MigrateScheduleData::NewAppointment.delete_all
  end
end
