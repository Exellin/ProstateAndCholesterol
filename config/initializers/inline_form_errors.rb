ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html = ""
  elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "input"

  elements.each do |e|
    html = %(<div class="has-error">#{html_tag}<span class="help-block">#{e.values[1]} 
    #{instance.error_message.first}</span></div>).html_safe
  end
  html
end