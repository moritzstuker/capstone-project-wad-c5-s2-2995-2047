module ApplicationHelper
  def i18n_enum(model, attr)
    I18n.t("activerecord.attributes.#{model.model_name.i18n_key}.#{attr.to_s.pluralize}.#{model.send(attr)}")
  end
end
