# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text
#  has_image  :boolean
#  image_url  :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { in: 3..256 }
  # validates :has_image, presence: true
  validates :user, presence: true
   
end
