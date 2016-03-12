class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites

  validates :title, presence: true, uniqueness: true, length: { minimum: 7 }
  validates :body, presence: true

  def category_name
    category.name if category
  end

  def self.search(search)
    where("title ILIKE ? OR body ILIKE ?", "%#{search}%", "%#{search}")
  end

  def fav_for(user)
    favourites.find_by_user_id(user)
  end

  def body_snippet
    if body.strip.length >= 100
      "#{body}..."
    else
      "#{body}"
    end
  end
end
