module SimpleFormHelper
  # inputs_for excluded fields
  SKIPPED_COLUMNS = [
    :created_at, :updated_at, :created_on, :updated_on,
    :lock_version, :version,

    # Devise
    :encrypted_password, :reset_password_token, :reset_password_sent_at,
    :last_sign_in_at, :last_sign_in_ip,
    :current_sign_in_at, :current_sign_in_ip,
    :remember_created_at, :approved_at,

    # CarrierWave Meta
    :avatar_meta, :image_meta,

    # Misc
    :avatar_tmp, :image_tmp,

    # Syncables
    :uuid
  ]

  def initialize(*args)
    super *args

    SimpleForm::FormBuilder.send(:include, form_user_mixin)
  end

  def form_user_mixin
    user = current_user
    # ability = current_ability

    form_user_mixin = Module.new
    form_user_mixin.send(:define_method, :current_user) { user }
    # form_user_mixin.send(:define_method, :current_ability) { ability }

    form_user_mixin
  end

  # Form Actions Helper

  def default_actions(options={}, &block)
    capture_haml do
      haml_tag 'div', class: 'panel-footer' do
        haml_tag 'fieldset', class: 'form-actions' do
          haml_tag 'button', class: "btn btn-success #{options[:class]}" do
            haml_tag 'span', class: icon_class(options[:icon] || 'check')
            haml_concat options[:submit] || "actions.submit".t
          end

          haml_concat capture_haml(&block) if block_given?

          if request.referrer && !options[:no_cancel]
            haml_tag 'a', href: request.referrer, class: "btn btn-danger #{options[:class]}" do
              haml_tag 'span', class: icon_class(options[:cancel_icon] || 'times')
              haml_concat options[:cancel] || 'actions.cancel'.t
            end
          end
        end
      end
    end
  end

  def each_field(model, &block)
    default_columns_for_object(model).each(&block)
  end

  # Automatic Form Generation Helper

  def inputs_for(model, form_builder)
    cols = []
    cols += content_columns(model)
    cols -= SKIPPED_COLUMNS
    cols -= model.class::SKIPPED_COLUMNS.map(&:intern) if model.class::SKIPPED_COLUMNS.present? rescue false
    cols += model.class::EXTRA_COLUMNS.map(&:intern) if model.class::EXTRA_COLUMNS.present? rescue false

    cols.compact

    res = ''
    cols.each do |col|
      col_type = model.get_column_display_type(col)
      field_partial = "application/input_#{col_type}"
      admin_field_partial = "admin/application/input_#{col_type}"
      if partial_exist?(admin_field_partial)
        res << render(partial: admin_field_partial, locals: { model: model, col: col, form: form_builder }).to_s
      elsif partial_exist?(field_partial)
        res << render(partial: field_partial, locals: { model: model, col: col, form: form_builder }).to_s
      else
        res << form_builder.input(col, placeholder: placeholder_for(model, col, form_builder), label: "#{model.class.name.underscore}.#{col}".tmf)
      end
    end

    cols = association_columns(model, :belongs_to)
    cols -= SKIPPED_COLUMNS
    cols -= model.class::SKIPPED_COLUMNS.map(&:intern) if model.class::SKIPPED_COLUMNS.present? rescue false
    cols.each do |col|
      val = instance_variable_get("@#{col}") rescue nil
      if val
        res << form_builder.hidden_field(model.class.reflections[col].foreign_key, value: val.id)
      else
        res << form_builder.association(col, placeholder: placeholder_for(model, col, form_builder), label: "#{model.class.name.underscore}.#{col}".tmf)
      end
    end

    res.html_safe
  end

  def placeholder_for(model, name, f)
    type = f.send(:default_input_type, name, model.class.columns_hash[name], {})

    s = I18n.t("simple_form.placeholders.#{model.class.name.underscore}.#{name}")

    if s =~ /translation missing/
      s = I18n.t("simple_form.placeholders.#{type}")
    end

    s
  end

  def association_columns(object, *by_associations)
    if object.present? && object.class.respond_to?(:reflections)
      object.class.reflections.collect do |name, association_reflection|
        if by_associations.present?
          if by_associations.include?(association_reflection.macro) && association_reflection.options[:polymorphic] != true
            name
          end
        else
          name
        end
      end.compact
    else
      []
    end
  end

  def default_columns_for_object(model)
    cols = association_columns(model, :belongs_to)
    cols += content_columns(model)
    cols -= SKIPPED_COLUMNS
    cols -= model.class::SKIPPED_COLUMNS.map(&:intern) if model.class::SKIPPED_COLUMNS.present? rescue false
    cols += model.class::EXTRA_COLUMNS.map(&:intern) if model.class::EXTRA_COLUMNS.present? rescue false

    cols.compact
  end

  def content_columns(object)
    # TODO: NameError is raised by Inflector.constantize. Consider checking if it exists instead.
    klass = object.class
    return [] unless klass.respond_to?(:content_columns)
    klass.content_columns.collect { |c| c.name.to_sym }.compact
  end


end
