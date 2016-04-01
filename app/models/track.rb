class Track < ActiveRecord::Base
  validates :name, :album_id, :bonus, presence: true

  belongs_to :albums
end
