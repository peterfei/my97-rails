module My97FormBuilder
    module FormHelper
        [:form_for, :fields_for,:simple_form_for].each do |method|
            module_eval do
                define_method "#{method}" do |record, *args, &block|
                options           = args.extract_options!
                options[:builder] = My97FormBuilder::FormBuilder

                if method == :form_for
                    options[:html] ||= {}
                    options[:html][:class] ||= 'form-horizontal'
                end

                # call the original method with our overridden options
                send method, record, *(args << options), &block
                end
            end
        end 
    end 
     class FormBuilder < ActionView::Helpers::FormBuilder
         #include FormHelper 
         
         def get_error_text(object, field, options)
             if object.nil? || options[:hide_errors]
                 ""
             else
                 errors = object.errors[field.to_sym]
                 if errors.empty? then "" else errors.first end
             end
         end

         def get_object_id(field, options)
             object = @template.instance_variable_get("@#{@object_name}")
             return options[:id] || object.class.name.underscore + '_' + field.to_s
         end

         def get_label(field, options)
             labelOptions = {:class => 'control-label'}.merge(options[:label] || {})
             text = labelOptions[:text] || nil
             labelTag = label(field, text, labelOptions)
         end
         def my97_date_select(field,options ={})
             id = get_object_id(field, options)
            options[:class]="Wdate"
             date = 
                 if options['start_date']
                     options['start_date']
                 elsif object.nil?
                     Date.now
                 else
                     object.send(field.to_sym)
                 end
             date_picker_script = "<script type='text/javascript'>" +
                      "$('##{id}')" +
                      ".focus( function() {
                           var options;
                           options = {
                            dateFmt: 'yyyy-MM-dd',
                            autoPickDate: null
                                     };
                              return WdatePicker($.extend(options, $(this).data()));
                             });" +"</script>"
             return basic_date_select(field, options.merge(javascript: date_picker_script))
         end 
         def basic_date_select(field, options = {})
             placeholder_text = options[:placeholder_text] || ''
             id = get_object_id(field, options)

             errorText = get_error_text(object, field, options)
             wrapperClass = 'control-group' + (errorText.empty? ? '' : ' error')
             errorSpan = if errorText.empty? then "" else "<span class='help-inline'>#{errorText}</span>" end

             labelTag = get_label(field, options)

             date = 
                 if options[:start_date]
                     options[:start_date]
                 elsif object.nil?
                     Date.now.utc
                 else
                     object.send(field.to_sym)
                 end

             javascript = options[:javascript] || 
                 "
              <script>
                $(function() { 
                  var el = $('##{id}');
                  var currentValue = el.val();
                  if(currentValue.trim() == '') return;
                  el.val(new Date(currentValue).toString('dd MMM, yyyy'));
                });
              </script>"
              ("<div class='#{wrapperClass}'>" + 
               labelTag +
               "<div class='controls'>" +
               text_field(field, {
                  :id => id, :placeholder => placeholder_text, :value => date.to_s,
                  :class => options[:class]
              }.merge(options[:text_field] || {})) + 
                  errorSpan +
                  javascript +
                  "</div>" +
                  "</div>").html_safe
         end 
        
         def my97_datetime_select(field,options ={})
             id = get_object_id(field, options)
             #options[:class]="Wdate"
             date = 
                 if options['start_date']
                     options['start_date']
                 elsif object.nil?
                     Date.now
                 else
                     object.send(field.to_sym)
                 end
             date_picker_script = "<script type='text/javascript'>" +
                 "$('##{id}')" +
                 ".focus( function() {
                           var options;
                           options = {
                            dateFmt: 'yyyy-MM-dd HH:mm:ss',
                            autoPickDate: null
                                     };
                              return WdatePicker($.extend(options, $(this).data()));
                             });" +"</script>"
             return basic_datetime_select(field, options.merge(javascript: date_picker_script))
         end
         def basic_datetime_select(field, options = {})
             placeholder_text = options[:placeholder_text] || ''
             id = get_object_id(field, options)

             errorText = get_error_text(object, field, options)
             wrapperClass = 'control-group' + (errorText.empty? ? '' : ' error')
             errorSpan = if errorText.empty? then "" else "<span class='help-inline'>#{errorText}</span>" end

             labelTag = get_label(field, options)

             date_time = 
                 if options[:start_time]
                     options[:start_time]
                 elsif object.nil?
                     DateTime.now.utc
                 else
                     object.send(field.to_sym)
                 end

             javascript = options[:javascript] || 
                     "
                  <script>
                    $(function() { 
                      var el = $('##{id}');
                      var currentValue = el.val();
                      if(currentValue.trim() == '') return;
                      el.val(new Date(currentValue).toString('dd MMM, yyyy HH:mm'));
                    });
                  </script>"

          ("<div class='#{wrapperClass}'>" + 
           labelTag +
           "<div class='controls'>" +
           text_field(field, {
              :id => id, :placeholder => placeholder_text, :value => date_time.to_s,
              :class => options[:class]
          }.merge(options[:text_field] || {})) + 
              errorSpan +
              javascript +
              "</div>" +
              "</div>").html_safe
         end
     end
end
