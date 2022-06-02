Review.destroy_all
puts "Reviews destroyed"
Marker.destroy_all
puts "Markers destroyed"
User.destroy_all
puts "Users destroyed"
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
  User.create!(email: 'a@a.com', username: 'James', password: '123456', photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654035245/users/yu2lfyywjmiyyzexogzp.jpg")
  User.create!(email: 'florent@gilet.com', username: 'Florent_G', password: '123456', photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654089313/users/ncp1nyrdwhshrydnen1z.jpg")
  User.create!(email: 'c@c.com', username: 'Stephane', password: '123456', photo: "https://avatars.githubusercontent.com/u/37821714?v=4")
  User.create!(email: 'd@d.com', username: 'Aurelien', password: '123456', photo: "https://avatars.githubusercontent.com/u/25286237?v=4")
  User.create!(email: 'e@e.com', username: 'Robert', password: '123456', photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1652972088/samples/people/kitchen-bar.jpg")
  User.create!(email: 'f@f.com', username: 'Linda', password: '123456', photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1652972094/samples/people/bicycle.jpg")
  User.create!(email: 'g@g.com', username: 'Sophie', password: '123456', photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1652972092/samples/people/boy-snow-hoodie.jpg")
end

user_list = []
User.all.each do |user|
  user_list << user
end

User.create!(email: 'blaisma@live.fr', username: 'Marc', password: '123456', photo: "https://avatars.githubusercontent.com/u/90230008?v=4")

# letter_array = ['a', 'b', 'c', 'd', 'e']

# letter_array.each do |letter|
#   @list_search = Geocoder.search(letter, params: { countrycodes: "ca"})
#   @list_search.each do |search|
#     Marker.create!(
#       title: select_title_data(search),
#       description: search.address,
#       latitude: search.latitude + rand(0.0001..0.0005),
#       longitude: search.longitude + rand(0.0001..0.0005),
#       user_id: user_list.sample.id
#     )
#   end
# end

Marker.create!(
  title: "Mont Sugar Loaf",
  description: "Go to the top and explore this awesome clear sky!",
  latitude: 46.879179,
  longitude: -70.397598,
  user_id: user_list.sample.id,
  photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654192455/samples/landscapes/231242581_10159585695944914_8405464899740385571_n_sdmraf.jpg"
)

Marker.create!(
  title: "Lac Ha-Ha",
  description: "Park your car on the parking, go to the stairs and ENJOY!",
  latitude: 47.997191,
  longitude: -70.780145,
  user_id: user_list.sample.id,
  photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654193689/samples/landscapes/196352919_10159478328024914_148844767911404191_n_pglvzg.jpg"
)

Marker.create!(
  title: "La Patrie",
  description: "Close to Mont Megantic, INTERNATIONAL DARK SKY RESERVE",
  latitude: 45.401821,
  longitude: -71.252853,
  user_id: user_list.sample.id,
  photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654193689/samples/landscapes/198260987_10159478328019914_5744544668368853112_n_n6vn2s.jpg"
)

Marker.create!(
  title: "Mont-Royal",
  description: "In front of Le Chalet du Mont-Royal, beautiful see on the Moon and the city",
  latitude: 45.507485,
  longitude: -73.590005,
  user_id: user_list.sample.id,
  photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654194395/samples/landscapes/pexels-alex-andrews-821718_zjqiyx.jpg"
)

photos_list = ["https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195557/samples/landscapes/pexels-nicole-avagliano-2312040_wntmeh.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195557/samples/landscapes/pexels-rachel-claire-7263774_lqyobu.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195556/samples/landscapes/pexels-eberhard-grossgasteiger-572897_3_uowk8t.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195554/samples/landscapes/pexels-sindre-str%C3%B8m-958363_xm9qm9.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195552/samples/landscapes/pexels-sindre-str%C3%B8m-955855_gslb87.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195552/samples/landscapes/pexels-chait-goli-2666598_xrjnmq.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195552/samples/landscapes/pexels-dom-le-roy-4065333_fiq4n6.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195550/samples/landscapes/pexels-margerretta-902756_vguexu.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195547/samples/landscapes/pexels-markus-spiske-1679701_qsqrjh.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195545/samples/landscapes/pexels-romario-roges-9582923_ymo2az.jpg"]

Marker.all.each do |marker|
  rand(3..5).times do
    Review.create(user: user_list.sample, marker: marker, rating: rand(3..5), content: ['Nice place!', 'Good location', 'Very enjoyable!', 'I took so many pictures!', 'Very wow', 'Did I see aliens?', 'Hard to get there, but awesome spot!', 'Beautiful', 'To infinity and beyond!', 'Houston we have a problem!', 'Looked up to the stars with Dark Side of the Moon album!', 'Took a bunch of nice pictures!', 'Next time, I bring my telescop!'].sample, date: Date.today, photos: photos_list.sample(4).join(", "))
  end
end

# http://api.positionstack.com/v1/forward?access_key=a5f3e8675d5ca91c470e9bbdcc288a62&country=CA&query=que
# http://api.positionstack.com/v1/
