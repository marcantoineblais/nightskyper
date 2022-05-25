User.destroy_all
puts "Users destroyed"
Review.destroy_all
puts "Reviews detroyed"
Marker.destroy_all
puts "Markers destroyed"
Favorite.destroy_all
puts "Favorites destroyed"

a = User.create!(email: 'a@a.com', username: 'Atest', password: '123456')
b = User.create!(email: 'b@b.com', username: 'Btest', password: '123456')
c = User.create!(email: 'c@c.com', username: 'Ctest', password: '123456')

# For the address :
# Check la gem de Geocoding

# http://api.positionstack.com/v1/forward?access_key=a5f3e8675d5ca91c470e9bbdcc288a62&country=CA&query=que
# http://api.positionstack.com/v1/
