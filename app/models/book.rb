class Book < ApplicationRecord
    belongs_to :author   # singular

    validates :title, presence: true,   uniqueness: true

    
end
