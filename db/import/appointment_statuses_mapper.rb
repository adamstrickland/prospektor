class Appointment StatusesMapper < Pipeline::TransformMapper
  define_mappings({
    'AppointmentStatusID' => { :to => :appointment_status_id},'AppointmentCode' => { :to => :appointment_code},'AppointmentStatusDescription' => { :to => :appointment_status_description},'BC Contacts' => { :to => :bc_contacts},'Sales Appt Codes' => { :to => :sales_appt_codes},'TeleSales Codes' => { :to => :tele_sales_codes},'SSMA_TimeStamp' => { :to => :created_at}
  })
end
