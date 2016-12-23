class User < ApplicationRecord
	acts_as_follower 
	acts_as_voter
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :pins
  has_friendship
  # acts_as_followable
end
