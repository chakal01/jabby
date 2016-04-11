class Post < ActiveRecord::Base
  belongs_to :blog
  has_many :images

  def path
    "./app/assets/images/posts/#{self.id}/"
  end

end
