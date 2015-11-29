class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment

  default_scope -> { order(created_at: :asc) }

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  scope :persisted, -> { where.not(id: nil) }
end
