# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  name        :string
#  email       :string
#  username    :string
#  phone       :string
#  facebook    :string
#  snapchat    :string
#  twitter     :string
#  instagram   :string
#  last_online :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class User < ApplicationRecord
end
