class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one_attached :image, dependent: :destroy
  has_one_attached :video, dependent: :destroy

  validate :user_post_limit, :on => :create
  validates :body, presence: true
  validates :title, presence: true,
					length: {minimum: 5}

#kuumade postituste scope
  scope :hot, ->{ where("likes_count > ?", 1,).where("created_at >= ?", 3.day.ago).order("likes_count DESC") }
#top postituste scope
  scope :top, ->{ where("likes_count > ?", 0,).order("likes_count DESC") }
#uute postituste scope
  scope :newposts, ->{ order('created_at DESC') }

#muudab postituse show page URL-i, lisab ID-le juurde pealkirja.
  def to_param
    "#{id} #{title}".parameterize
  end


	private 

# Kontrollib kas kasutaja onteinud päevas rohkem kui 3 postitust.
	  def user_post_limit 
	   if user.posts.today.count >= 3
	     errors.add(:base, "Päevalimiit on täis")
	   else

	   end
	  end


end
