require('pg')
require_relative('../db/sql_runner')
class Artist

attr_reader :id, :name

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()

sql = "INSERT INTO artists ( name ) VALUES ( $1 ) RETURNING id"
values = [@name]
@id = SqlRunner.run(sql, values)[0]['id'].to_i

end
def self.all()
  sql = "SELECT * FROM artists;"
  artists = SqlRunner.run(sql)
  return artists.map { | artist | Artist.new(artist)}
end

def find_albums()
  sql = "SELECT * FROM albums WHERE artist_id = $1"
  values = [@id]
  results = SqlRunner.run(sql, values)
  albums = results.map { |album| Album.new(album)}
  return albums
end









end
