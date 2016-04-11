class Blog < ActiveRecord::Base
  belongs_to :camp
  has_many :posts
end
