class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy, :inverse_of :author

  def vote(post)
  end

  def share(post)
  end
end
