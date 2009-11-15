module LeadsHelper
  def timezone_mapping(tz_letter)
    case tz_letter
      when 'C' then 'Central'
      when 'E' then 'Eastern'
      when 'M' then 'Mountain'
      when 'P' then 'Pacific'
      else tz_letter
    end
  end
end
