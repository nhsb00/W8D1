class Sub < ApplicationRecord
    validates :title, :description, :moderator_id, presence: true

    belongs_to :moderator,
    foreign_key: :moderator_id,
    primary_key: :id,
    class_name: :User

    has_many :post_subs,
    foreign_key: :sub_id,
    primary_key: :id,
    class_name: :PostSub

    has_many :posts,
    through: :post_subs,
    source: :post
    
end

# has_many :posts,
# foreign_key: :sub_id,
# primary_key: :id,
# class_name: :Post