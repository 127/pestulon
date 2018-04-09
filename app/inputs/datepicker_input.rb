#http://stackoverflow.com/questions/5007785/how-do-i-write-a-cleaner-date-picker-input-for-simpleform
# class DatepickerInput < SimpleForm::Inputs::Base
#   def input
#     @builder.text_field(attribute_name, input_html_options) + \
#     @builder.hidden_field(attribute_name, { :class => attribute_name.to_s + "-alt"})
#   end
# end
class DatepickerInput < SimpleForm::Inputs::Base
  def input wrapper_options
    value = object.send(attribute_name) if object.respond_to? attribute_name
    input_html_options[:value] = value.present? ? I18n.localize(value, { :format => "%Y-%m-%d" }) : Time.now.to_date
    input_html_options[:class] << 'form-control'
    @builder.text_field(attribute_name,input_html_options) + \
    @builder.hidden_field(attribute_name, {:id => 'datepicker-hidden', :class => attribute_name.to_s + "-alt", :value => input_html_options[:value]})
  end
end
