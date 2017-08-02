module ApplicationHelper

  def flash_class_name(name)
    case name
      when 'notice' then 'success'
      when 'alert'  then 'danger'
      else name
    end
  end

  def months_select_array
    [["January", "0"], ["February", "1"], ["March", "2"], ["April", "3",], ["May", "4"], ["June", "5"],
    ["July", "6"], ["August", "7"], ["September", "8"], ["October", "9"], ["November", "10"], ["December", "11"]]
  end

  def birth_year_select_array
    (120.years.ago.year..18.years.ago.year).collect { |year| [year] }.reverse
  end

  def age_select_array
    (18..120).collect { |year| [year] }
  end

  def years_ago_select_array
    (0..120).collect { |year| [year] }
  end

  def year_select_array
    (120.years.ago.year..0.years.ago.year).collect { |year| [year] }.reverse
  end
end
