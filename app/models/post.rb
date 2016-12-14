class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  validates :author, presence: true

  validates :archived, inclusion: { in: [true, false] }

  default_scope -> { where(archived: false) }
  scope :all, -> { order(:created_at, :desc) }
  scope :archived, -> { where(archived: true) }
end
