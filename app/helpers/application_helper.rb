module ApplicationHelper
	class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
		def field_helper(attribute, options={}, &basetag)
			label(attribute, options[:label], {class:"col-sm-3 control-label"}) + 
				@template.content_tag(:div,	(yield attribute, options.merge({class:"form-control",label:nil})), :class => "col-sm-9")
		end
		def text_field(attribute, options={})
			field_helper(attribute, options) do |attrib, opts| super(attrib, opts) end
		end
		def password_field(attribute, options={})
			field_helper(attribute, options) do |attrib, opts| super(attrib, opts) end
		end
		def submit(options={})
			super(options.merge(:class => "btn btn-primary"))
		end
	end

	@@formopts = {builder: BootstrapFormBuilder, html: {role:"form", class:"form-horizontal"}}

	def bootstrap_form_for(record, options={}, &block)
		form_for(record, options.merge(@@formopts), &block)
	end
end
