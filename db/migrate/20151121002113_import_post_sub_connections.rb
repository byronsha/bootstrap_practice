class ImportPostSubConnections < ActiveRecord::Migration
  def change
    transaction do
      Post.select(:id, :sub_id).each do |post|
        PostSub.create!(post_id: post.id, sub_id: post.sub_id)
      end
      remove_column :posts, :sub_id
    end
  end
end
