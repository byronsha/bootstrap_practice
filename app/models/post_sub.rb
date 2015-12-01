class PostSub < ActiveRecord::Base
  belongs_to :post
  belongs_to :sub

  validates :post, :sub_id, presence: true
end
