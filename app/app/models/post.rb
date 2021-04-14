class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one_attached :image, dependent: :destroy
  has_one_attached :cover, dependent: :destroy

  validate :user_post_limit, :on => :create
  validates :body, presence: true
  validates :title, presence: true,
					length: {minimum: 5}

#kuumade postituste scope
  scope :hot, -> { joins("LEFT OUTER JOIN Likes ON likes.post_id = posts.id 
                     AND likes.created_at BETWEEN '#{DateTime.now.beginning_of_day}' AND '#{DateTime.now.end_of_day}'")
                    .group("posts.id").order("COUNT(likes.id) DESC") }
#top postituste scope
  scope :top, ->{ where("likes_count >= ?", 0,).order("likes_count DESC") }
#uute postituste scope
  scope :newposts, ->{ order('created_at DESC') }

#muudab postituse show page URL-i, lisab ID-le juurde pealkirja.
  def to_param
    "#{id} #{title}".parameterize
  end


	private 

# Kontrollib kas kasutaja onteinud päevas rohkem kui 3 postitust.
	  def user_post_limit 
	   if user.posts.today.count >= 15
	     errors.add(:base, "Päevalimiit on täis")
	   else

	   end
	  end


end
