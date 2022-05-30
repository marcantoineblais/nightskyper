Review.destroy_all
puts "Reviews detroyed"
Marker.destroy_all
puts "Markers destroyed"
# User.destroy_all
# puts "Users destroyed"
# Favorite.destroy_all
# puts "Favorites destroyed"

def select_title_data(inst)
  if(inst.town)
    inst.town
  elsif(inst.postal_code)
    inst.postal_code
  elsif(inst.county)
    inst.county
  elsif(inst.city)
    inst.city
  else
    inst.state
  end
end

unless User.count.positive?
  User.create!(email: 'a@a.com', username: 'Atest', password: '123456')
  User.create!(email: 'b@b.com', username: 'Btest', password: '123456')
  User.create!(email: 'c@c.com', username: 'Ctest', password: '123456')
end

user_list = [User.first, User.second, User.last]

letter_array = ['a', 'b', 'c', 'd', 'e']

letter_array.each do |letter|
  @list_search = Geocoder.search(letter, params: { countrycodes: "ca"})
  @list_search.each do |search|
    Marker.create!(
      title: select_title_data(search),
      description: search.address,
      latitude: search.latitude + rand(0.0001..0.0005),
      longitude: search.longitude + rand(0.0001..0.0005),
      user_id: user_list.sample.id
    )
  end
end

Marker.all.each do |marker|
  rand(3..5).times do
    Review.create(user: User.all.sample, marker: marker, rating: rand(3..5), content: ['Nice place!', 'Good location', 'Very enjoyable!', 'I took so many pictures!', 'Very wow'].sample, date: Date.today)
  end
end

# http://api.positionstack.com/v1/forward?access_key=a5f3e8675d5ca91c470e9bbdcc288a62&country=CA&query=que
# http://api.positionstack.com/v1/
