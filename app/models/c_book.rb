class CBook < ApplicationRecord
  include CatalogService
  def self.title_search(query)
    where('similarity(name, ?) > 0.1', query)
      .order("similarity(name, #{ActiveRecord::Base.connection.quote(query)}) DESC")
  end
end
