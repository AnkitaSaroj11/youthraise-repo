module FormBuilders
  class TailwindFormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::TagHelper

    class_attribute :text_field_helpers, default: field_helpers - [:label, :check_box, :radio_button, :fields_for, :fields, :hidden_field, :file_field]
    #  leans on the FormBuilder class_attribute `field_helpers`
    #  you'll want to add a method for each of the specific helpers listed here if you want to style them

    TEXT_FIELD_STYLE = "block text-sm rounded-lg w-full border border-slate-300 shadow-sm mt-2 hover:bg-white".freeze
    SELECT_FIELD_STYLE = "block bg-gray-200 text-gray-700 py-2 px-4 rounded leading-tight focus:outline-none focus:bg-white".freeze
    SUBMIT_BUTTON_STYLE = "bg-indigo-900 text-white px-8 py-3 rounded-lg hover:bg-indigo-700 cursor-pointer".freeze

    text_field_helpers.each do |field_method|
      class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
          def #{field_method}(method, options = {})
            if options.delete(:tailwindified)
              super
            else
              text_like_field(#{field_method.inspect}, method, options)
            end
          end
      RUBY_EVAL
    end

    def submit(value = nil, options = {})
      custom_opts, opts = partition_custom_opts(options)
      classes = apply_style_classes(SUBMIT_BUTTON_STYLE, custom_opts)

      super(value, {class: classes}.merge(opts))
    end

    def select(method, choices = nil, options = {}, html_options = {}, &block)
      custom_opts, opts = partition_custom_opts(options)
      classes = apply_style_classes(SELECT_FIELD_STYLE, custom_opts, method)

      labels = labels(method, custom_opts[:label], options)
      field = super(method, choices, opts, html_options.merge({class: classes}), &block)

      labels + field
    end

    def money_field(method, options)
      custom_opts, opts = partition_custom_opts(options)
      classes = apply_style_classes(TEXT_FIELD_STYLE + " pl-7 pr-12", custom_opts, method)

      labels = custom_opts[:label] == false ? '' : labels(method, custom_opts[:label], options)
      
      field = text_field(method, {
        class: classes,
        title: errors_for(method)&.join(" ")
      }.compact.merge(opts).merge({tailwindified: true}))

      group = 
        tag.div(
          tag.div(
            tag.span("$", class: "text-gray-500 sm:text-sm"),
            class: "pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3"
          ) + 
          field + 
          tag.div(
            tag.span("USD", class: "text-gray-500 sm:text-sm", id: "price-currency"),
            class: "pointer-events-none absolute inset-y-0 right-0 flex items-center pr-3"
          ),
          class: "relative mt-1 rounded-md shadow-sm"
        )
      labels + group
    end

    private

    def text_like_field(field_method, object_method, options = {})
      custom_opts, opts = partition_custom_opts(options)

      classes = apply_style_classes(TEXT_FIELD_STYLE, custom_opts, object_method)
      field = send(field_method, object_method, {
        class: classes,
        title: errors_for(object_method)&.join(" ")
      }.compact.merge(opts).merge({tailwindified: true}))
      
      labels = labels(object_method, custom_opts[:label], options)

      labels + field
    end

    def labels(object_method, label_options, field_options)
      label = tailwind_label(object_method, label_options, field_options)
      error_label = error_label(object_method, field_options)

      @template.content_tag("div", label + error_label, {class: "flex flex-col items-start"})
    end

    def tailwind_label(object_method, label_options, field_options)
      text, label_opts = if label_options.present?
        [label_options[:text], label_options.except(:text)]
      else
        [nil, {}]
      end

      label_classes = label_opts[:class] || "font-sans font-semibold text-slate-500"
      label_classes += " text-yellow-800 dark:text-yellow-400" if field_options[:disabled]
      label(object_method, text, {
        class: label_classes
      }.merge(label_opts.except(:class)))
    end

    def error_label(object_method, options)
      if errors_for(object_method).present?
        error_message = @object.errors[object_method].collect(&:titleize).join(", ")
        tailwind_label(object_method, {text: error_message, class: " font-bold text-red-500"}, options)
      end
    end

    def border_color_classes(object_method)
      if errors_for(object_method).present?
        " border-2 border-red-400 focus:border-rose-200"
      else
        " border border-gray-300 focus:border-yellow-700"
      end
    end

    def apply_style_classes(classes, custom_opts, object_method = nil)
      classes + border_color_classes(object_method) + " #{custom_opts[:class]}"
    end

    CUSTOM_OPTS = [:label, :class].freeze
    def partition_custom_opts(opts)
      opts.partition { |k, v| CUSTOM_OPTS.include?(k) }.map(&:to_h)
    end

    def errors_for(object_method)
      return unless @object.present? && object_method.present?

      @object.errors[object_method]
    end
  end
end