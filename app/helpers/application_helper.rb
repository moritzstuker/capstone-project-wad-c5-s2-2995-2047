module ApplicationHelper
  def i18n_enum(model, attr)
    t("#{model.model_name.i18n_key.to_s.pluralize}.attributes.#{attr.to_s.pluralize}.#{model.send(attr)}")
  end
end
