class Book < ApplicationRecord
    belongs_to :subject
    validates_presence_of :title
    validates_numericality_of :price, :message=>"Unavailable book price"
end
