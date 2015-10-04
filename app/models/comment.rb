class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }
  scope :persisted, -> { where('id IS NOT NULL') }

  belongs_to :user
end
