class ActionView::Helpers::FormBuilder
  alias :orig_label :label

  def label(method, text = nil, options = {}, &block)
    
    if options[:nested_object_class]
      class_variable = Object.const_get(options[:nested_object_class])
    else
      class_variable = object.class
    end
    
    if class_variable.validators_on(method).map(&:class).include?(ActiveRecord::Validations::PresenceValidator)
      options[:class] = ((options[:class] || "") + " required").split(" ").uniq.join(" ")
    end

    self.orig_label(method, text, options, &block)
  end
end