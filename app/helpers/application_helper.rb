module ApplicationHelper
	
	class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
		def field_helper(attribute, options={}, &basetag)

			no_label = options[:no_label] == true #there has *got* to be a better way to do this test
			field = @template.content_tag(:div, (yield attribute, options.merge({class:"form-control", label:nil})), :class => no_label ? "" : "col-sm-9")
			if no_label
				field
			else
				label(attribute, options[:label], {class:(no_label ? "" : "col-sm-3 ") + "control-label"}) + field
			end
				
		end
		def text_field(attribute, options={})
			field_helper(attribute, options) do |attrib, opts| super(attrib, opts) end
		end
		def password_field(attribute, options={})
			field_helper(attribute, options) do |attrib, opts| super(attrib, opts) end
		end
		def number_field(attribute, options={})
			field_helper(attribute, options) do |attrib, opts| super(attrib,opts) end
		end
		def check_box(attribute, options={})
			@template.content_tag(:div, (
					super(attribute, options) + " " +
					label(attribute, options[:label], {class:"control-label"})
				), {class:"col-sm-9 col-sm-offset-3 text-left"})
		end
		def submit(options={})
			super(options.merge(:class => "btn btn-primary"))
		end
	end

	@@formopts = {builder: BootstrapFormBuilder, html: {role:"form", class:"form-horizontal"}}

	def bootstrap_form_for(record, options={}, &block)
		form_for(record, options.merge(@@formopts), &block)
	end

	def select(record, attribute, values, options={}, html_options={})
		# hating this ugly stringification here - gotta be a railsy way to get at the default idification of a record attribute
		label_tag( record.to_s + "_" + attribute.to_s, options[:label], {class:"col-sm-3 control-label"}) + 
				content_tag(:div, super(record, attribute, values, options, html_options.merge({class:"form-control", label:nil})), :class => "col-sm-9")
	end

	def title(page_title)
		content_for(:title) {page_title}
	end
end
