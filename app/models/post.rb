class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validates :sub_ids, presence: true
  # belongs_to :sub

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: "User"

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs

end
