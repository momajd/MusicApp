class AddLyricsToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :lyrics, :string
  end
end
