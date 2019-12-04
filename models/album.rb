require('pg')
require_relative('../db/sql_runner')
class Album

attr_reader :id, :title, :genre, :artist_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id']
  end

  def save()
    sql = "INSERT INTO albums (title, genre, artist_id ) VALUES ( $1, $2, $3 ) RETURNING id"
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM albums;"
    albums = SqlRunner.run(sql)
    return albums.map { | album | Album.new(album)}
  end

  def find_artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    artist_data = result[0]
    artist = Artist.new(artist_data)
    return artist
  end



end
