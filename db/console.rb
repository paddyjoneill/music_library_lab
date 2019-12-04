require('pry')
require_relative('../models/album')
require_relative('../models/artist')

Album.delete_all
Artist.delete_all


artist1 = Artist.new({'name' => 'Take That'})
artist1.save()


album1 = Album.new({
  'artist_id' => artist1.id,
  'title' => 'Greatest Hits',
  'genre' => 'Pop'
  })
album1.save()

album2 = Album.new({
  'artist_id' => artist1.id,
  'title' => 'The Circus',
  'genre' => 'Pop'
  })
album2.save()


binding.pry
nil
