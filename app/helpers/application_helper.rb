module ApplicationHelper
  
  def flash_class_name(name)
    case name
      when 'notice' then 'success'
      when 'alert'  then 'danger'
      else name
    end
  end
  
  def months_select_array
    [["January", "1"], ["February", "2"], ["March", "3"], ["April", "4",], ["May", "5"], ["June", "6"], 
    ["July", "7"], ["August", "8"], ["September", "9"], ["October", "10"], ["November", "11"], ["December", "12"]]
  end
end
