class Pin < ApplicationRecord
  acts_as_votable
  acts_as_commentable
  acts_as_followable

  resourcify

  include PublicActivity::Model
  tracked only: [:create, :upvote, :follow, :update, :like], owner: proc { |_controller, model| model.user }

  belongs_to :user
  has_attached_file :image, styles: { medium: "300x300>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\z}
end
