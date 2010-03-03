class ChangeSchedulesToAppointments < ActiveRecord::Migration
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
  def self.up
    rename_table :schedules, :old_appointments
  end

  def self.down
    rename_table :old_appointments, :schedules
  end
end
