class Link

  include DataMapper::Resource

  has n, :tags, through: Resource
  # belongs_to :user, required: false

  property :id, Serial
  property :title, String
  property :url, String
end
