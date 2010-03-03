require 'chronic'

class AlterAppointments < ActiveRecord::Migration
# CREATE TABLE `appointments` (
#   `id` int(11) NOT NULL AUTO_INCREMENT,
#   `client_email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
#   `expert_email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
#   `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
#   `duration` float NOT NULL DEFAULT '1',
#   `notes` text COLLATE utf8_unicode_ci,
#   `session_date` date NOT NULL,
#   `session_time` time NOT NULL,
#   `lead_id` int(11) NOT NULL,
#   `scheduler_id` int(11) NOT NULL,
#   `created_at` datetime DEFAULT NULL,
#   `updated_at` datetime DEFAULT NULL,
#   `topic_id` int(11) DEFAULT '1',
#   PRIMARY KEY (`id`)
# ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci

# CREATE TABLE `schedules` (
#    `id` int(11) NOT NULL AUTO_INCREMENT,
#    `contact_id` int(11) DEFAULT NULL,
#    `cb_date` datetime DEFAULT NULL,
#    `cb_time` datetime DEFAULT NULL,
#    `sale_probability` int(11) DEFAULT NULL,
#    `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
#    `appt_status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
#    `created_at` datetime DEFAULT NULL,
#    `user_id` int(11) DEFAULT NULL,
#    `references_requested` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
#    `no_sale_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
#    `problem1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
#    `impact1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
#    `problem2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
#    `impact2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
#    `problem3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
#    `impact3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
#    `updated_at` datetime DEFAULT NULL,
#    `entered` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
#    `callback_at` datetime DEFAULT NULL,
#    PRIMARY KEY (`id`)
#  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci

  class NewAppointment < ActiveRecord::Base
    set_table_name 'appointments'
    belongs_to :lead
    belongs_to :user
    belongs_to :status, :class_name => 'AppointmentStatus'
  end
  
  def self.up
    #first create the table
    create_table :appointments do |t|
      t.references :lead, :null => false
      t.references :user, :null => false
      t.references :status, :null => false, :polymorphic => { :default => 'AppointmentStatus' }
      t.datetime :scheduled_at
      t.integer :duration, :null => false, :default => 0
      t.decimal :sale_probability, :null => false, :precision => 2, :default => 0
      t.string :no_sale_reason, :length => 2000
      t.boolean :references_requested, :default => false
      (1..3).each do |i|
        t.string "problem_#{i}".to_sym
        t.integer "impact_#{i}".to_sym
      end
      t.text :comments
      
      t.timestamps
    end
    
    #import data from schedules
    AlterAppointments::NewAppointment.reset_column_information
    
    Schedule.all.each do |s|
      a = AlterAppointments::NewAppointment.new
      a.lead = s.contact.lead
      a.user = s.employee.user
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
      a.sale_probability = s.sale_probability
      a.no_sale_reason = s.no_sale_reason
      a.references_requested = (s.references_requested.strip == '1')
      (1..3).each do |i|
        a.send("problem_#{}=".to_sym, s.send("problem#{i}")) if s.send("problem#{i}")
        a.send("impact_#{}=".to_sym, s.send("impact#{i}").to_i) if s.send("impact#{i}")
      end
      a.comments = s.comments
      a.created_at = Chronic.parse(s.entered) if s.entered.present?
      a.save
    end
  end

  def self.down
    remove_table :appointments
  end
end
