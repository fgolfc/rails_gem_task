# app/models/concerns/ransack_search.rb
module RansackSearch
  extend ActiveSupport::Concern

  included do
    ransacker :title_or_description do
      Arel.sql("CONCAT_WS(' ', title, description)")
    end
  end
end
