class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :email, uniqueness: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }, :length => { :maximum => 25 }
  validates :bio, :length => { :maximum => 100 }

  has_many :likes, dependent: :destroy
  has_many :received_likes, through: :posts, class_name: "Like"
  has_many :hearts, dependent: :destroy

  has_many :following, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  
  has_many :posts, dependent: :destroy do

    def today
      where(:created_at => (Time.zone.now.beginning_of_day..Time.zone.now))
    end

  end

    def received_likes
      posts.map { |p| p.likes.size}.reduce(0, :+)
    end

  has_many :comments, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

  scope :online , ->{where("last_seen_at > ?", 5.minutes.ago) }


end
