class Post < ApplicationRecord
    valiadates :title, :content, presence: true
    
    belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: :User
    
    has_many :post_subs,
    foreign_key: :post_id
    primary_key: :id,
    class_name: :PostSub
    
    has_many :subs,
    through: :post_subs,
    source: :sub
end
