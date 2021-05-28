module Filtering
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(params)
      results = self.where(nil)
      params.each do |key, value|
        results = results.public_send("filter_by_#{key}", value) if value.present?
      end
      results
    end
  end
end
