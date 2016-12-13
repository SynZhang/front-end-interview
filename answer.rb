# 1. limit 的返回结果是一个最多 n 条记录的集合，所以可能会遇到 0 条记录的情况，这样在这里调用 post.author 时就会报错。
# 2. 单单设置 belongs_to 的话也可能遇到 author 为 nil 的情况，因此这种情况下调用 post.author.name 会报错。

class Post < ActiveRecord::Base
  belongs_to :author
  validates :author, presence: true
end

posts = Post.limit(50)
posts.present? && posts.each do |post|
  puts post.author.name
end
