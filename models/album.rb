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

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def update_title(new_title)
    @title = new_title
    sql = "UPDATE albums SET title = $1 WHERE id = $2"
    values = [new_title, @id]
    SqlRunner.run(sql, values)
  end

  def update_genre(new_genre)
    @genre = new_genre
    sql = "UPDATE albums SET genre = $1 WHERE id = $2"
    values = [new_genre, @id]
    SqlRunner.run(sql, values)
  end

  def update_artist_id(new_artist_id)
    @artist_id = new_artist_id
    sql = "UPDATE albums SET artist_id = $1 WHERE id = $2"
    values = [new_artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    album_data = result[0]
    return Album.new(album_data)
  end

end
