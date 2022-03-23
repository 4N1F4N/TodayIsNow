class Post < ApplicationRecord
  belongs_to :user
  
  validates :heading, :text, presence: true;
  validates :heading, length: { in: 6..20 }
  validates :text, length: { in: 6..200 }
end
