class Post < ActiveRecord::Base
  belongs_to :category
  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: true, length: { minimum: 7 }
  validates :body, presence: true, uniqueness: true

  def category_name
    category.name if category
  end

  def self.search(search)
    where("title ILIKE ? OR body ILIKE ?", "%#{search}%", "%#{search}")
  end

  def body_snippet
    if body.strip.length >= 100
      "#{body}..."
    else
      "#{body}"
    end
  end
end
