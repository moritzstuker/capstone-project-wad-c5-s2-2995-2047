class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :aws
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback_avatars/" + [version_name, "1.jpg"].compact.join('_'))
  end

  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  resize_to_fill 400, 400
end
