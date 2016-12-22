class Follow < ActiveRecord::Base
	include PublicActivity::Model
	tracked only: [:create, :destroy]#, owner: Proc.new{ |controller, model| model.user }

  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" interface, and also to followers
  belongs_to :followable, :polymorphic => true
  belongs_to :follower,   :polymorphic => true

  def block!
    self.update_attribute(:blocked, true)
  end

end
