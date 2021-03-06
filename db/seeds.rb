Favorite.destroy_all
puts "Favorites destroyed"
Review.destroy_all
puts "Reviews destroyed"
Marker.destroy_all
puts "Markers destroyed"
User.destroy_all
puts "Users destroyed"

# def select_title_data(inst)
#   if(inst.town)
#     inst.town
#   elsif(inst.postal_code)
#     inst.postal_code
#   elsif(inst.county)
#     inst.county
#   elsif(inst.city)
#     inst.city
#   else
#     inst.state
#   end
# end

photos_list = ["https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195557/samples/landscapes/pexels-nicole-avagliano-2312040_wntmeh.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195557/samples/landscapes/pexels-rachel-claire-7263774_lqyobu.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195556/samples/landscapes/pexels-eberhard-grossgasteiger-572897_3_uowk8t.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195554/samples/landscapes/pexels-sindre-str%C3%B8m-958363_xm9qm9.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195552/samples/landscapes/pexels-sindre-str%C3%B8m-955855_gslb87.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195552/samples/landscapes/pexels-chait-goli-2666598_xrjnmq.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195552/samples/landscapes/pexels-dom-le-roy-4065333_fiq4n6.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195550/samples/landscapes/pexels-margerretta-902756_vguexu.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195547/samples/landscapes/pexels-markus-spiske-1679701_qsqrjh.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195545/samples/landscapes/pexels-romario-roges-9582923_ymo2az.jpg"]

unless User.count.positive?
  puts "Demo users created"
  User.create(email: 'e@e.com', username: 'James', password: '123456', photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654035245/users/yu2lfyywjmiyyzexogzp.jpg")
  User.create(email: 'a@a.com', username: 'Marc', password: '123456', photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1652993315/production/vmmdg658dl3sjz12miv0s2hag31o.jpg")
  User.create(email: 'florent@gilet.com', username: 'Florent_G', password: '123456', photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654089313/users/ncp1nyrdwhshrydnen1z.jpg")
  User.create(email: 'c@c.com', username: 'Stephane', password: '123456', photo: "https://avatars.githubusercontent.com/u/37821714?v=4")
  User.create(email: 'd@d.com', username: 'Aurelien', password: '123456', photo: "https://avatars.githubusercontent.com/u/25286237?v=4")
  linda = User.create(email: 'f@f.com', username: 'Linda', password: '123456', photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1652972094/samples/people/bicycle.jpg")
  sophie = User.create(email: 'g@g.com', username: 'Sophie', password: '123456', photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1652972092/samples/people/boy-snow-hoodie.jpg")
  User.create(email: 'h@h.com', username: 'Sali', password: '123456', photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654205255/samples/landscapes/whatsapp_image_2022-05-02_at_4.09.16_pm__1__trcbc4.jpg")
end

user_list = []
User.last(8).each do |user|
  user_list << user
end

User.create(email: 'blaisma@live.fr', username: 'Marc', password: 123456, photo: 'https://avatars.githubusercontent.com/u/90230008?v=4')

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
photos_city = ["https://res.cloudinary.com/diiu2j0fw/image/upload/v1654194395/samples/landscapes/pexels-alex-andrews-821718_zjqiyx.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195550/samples/landscapes/pexels-margerretta-902756_vguexu.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654282534/samples/landscapes/pexels-samer-daboul-1275413_ljr4bx.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195552/samples/landscapes/pexels-chait-goli-2666598_xrjnmq.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195552/samples/landscapes/pexels-sindre-str%C3%B8m-955855_gslb87.jpg"]
photos_countryside = ["https://res.cloudinary.com/diiu2j0fw/image/upload/v1654192455/samples/landscapes/231242581_10159585695944914_8405464899740385571_n_sdmraf.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654193689/samples/landscapes/196352919_10159478328024914_148844767911404191_n_pglvzg.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654193689/samples/landscapes/198260987_10159478328019914_5744544668368853112_n_n6vn2s.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195557/samples/landscapes/pexels-nicole-avagliano-2312040_wntmeh.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195557/samples/landscapes/pexels-rachel-claire-7263774_lqyobu.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195556/samples/landscapes/pexels-eberhard-grossgasteiger-572897_3_uowk8t.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195554/samples/landscapes/pexels-sindre-str%C3%B8m-958363_xm9qm9.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195552/samples/landscapes/pexels-sindre-str%C3%B8m-955855_gslb87.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195552/samples/landscapes/pexels-chait-goli-2666598_xrjnmq.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195550/samples/landscapes/pexels-margerretta-902756_vguexu.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195547/samples/landscapes/pexels-markus-spiske-1679701_qsqrjh.jpg", "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195545/samples/landscapes/pexels-romario-roges-9582923_ymo2az.jpg"]

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
  title: "Laval",
  description: "In the field behind my house, perfect to look at the moon!",
  latitude: 45.630760,
  longitude: -73.730225,
  user_id: user_list.sample.id,
  photo: "https://images.pexels.com/photos/2244823/pexels-photo-2244823.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
)

Marker.create!(
  title: "Brossard",
  description: "In the park here, perfect spot to look the full Moon or any eclipses.",
  latitude: 45.445452,
  longitude: -73.417758,
  user_id: user_list.sample.id,
  photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/c_scale,w_800/v1654199906/samples/landscapes/pexels-dan-hadley-6017481_lgf5zl.jpg"
)

Marker.create!(
  title: "Saint Jerome",
  description: "There is a hill here where you can install yourself and explore the sky. Not much light around.",
  latitude: 45.778488,
  longitude: -74.002609,
  user_id: user_list.sample.id,
  photo: photos_countryside.sample
)

Marker.create!(
  title: "Trois-Rivieres",
  description: "Park just there to check to the moon!",
  latitude: 46.343461,
  longitude: -72.543602,
  user_id: user_list.sample.id,
  photo: photos_city.sample
)

Marker.create!(
  title: "Magog",
  description: "Have a seat on the border of the lake and watch to the moon with the Mont Orford.",
  latitude: 45.266178,
  longitude: -72.153381,
  user_id: user_list.sample.id,
  photo: photos_city.sample
)

Marker.create!(
  title: "Chambly",
  description: "Take a good beer and watch to the moon near the Fort de Chambly.",
  latitude: 45.445080,
  longitude: -73.287666,
  user_id: user_list.sample.id,
  photo: photos_city.sample
)

Marker.create!(
  title: "Saint Donat de Mont-Calm",
  description: "Good Bortle there, easy to observe the milky way during new moon.",
  latitude: 46.267760,
  longitude: -74.224200,
  user_id: user_list.sample.id,
  photo: photos_countryside.sample
)

Marker.create!(
  title: "Quebec",
  description: "Look at the moon on the top of Chateau-Frontenac.",
  latitude: 46.805097,
  longitude: -71.216281,
  user_id: user_list.sample.id,
  photo: photos_city.sample
)

Marker.create!(
  title: "Rimouski",
  description: "Medium Bortle here, if new moon, you can see a bunch of deep sky objects.",
  latitude: 48.448891,
  longitude: -68.524033,
  user_id: user_list.sample.id,
  photo: photos_countryside.sample
)

Marker.create!(
  title: "Tadoussac",
  description: "You won't see a whale in the sky, but Andromede and the Milky Way pretty well!",
  latitude: 48.148312,
  longitude: -69.717957,
  user_id: user_list.sample.id,
  photo: photos_countryside.sample
)

Marker.create!(
  title: "Ottawa",
  description: "Go to this park and you will have a beautiful view on the moon with the parlement.",
  latitude: 45.421532,
  longitude: -75.697189,
  user_id: user_list.sample.id,
  photo: photos_city.sample
)

Marker.create!(
  title: "Jardin Botanique",
  description: "Observe the moon at the top of the Parc Olympique. Beautiful!",
  latitude: 45.560422,
  longitude: -73.555343,
  user_id: user_list.sample.id,
  photo: photos_city.sample
)


Marker.all.each do |marker|
  rand(1..6).times do
    Review.create(user: user_list.sample, marker: marker, rating: rand(3..5), content: ['Nice place!', 'Good location', 'Very enjoyable!', 'I took so many pictures!', 'Very wow', 'Hard to get there, but awesome spot!', 'Beautiful', 'To infinity and beyond!', 'Houston we have a problem!', 'Looked up to the stars with Dark Side of the Moon album!', 'Took a bunch of nice pictures!', 'Next time, I bring my telescop!'].sample, date: Date.today, photos: photos_list.sample(4).join(", "))
  end
end


montroyal = Marker.create!(
  title: "Mont-Royal",
  description: "In front of Le Chalet du Mont-Royal, beautiful see on the Moon and the city",
  latitude: 45.507485,
  longitude: -73.590005,
  user_id: user_list.sample.id,
  photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654272915/samples/landscapes/pexels-photo-993019_ufngvm.jpg"
)

mont_review = Review.new(user: User.last, rating: 3, content: 'Sit on the Chalet steps, and enjoy the moon with our beautiful downtown.', date: Date.yesterday, photos: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195556/samples/landscapes/pexels-eberhard-grossgasteiger-572897_3_uowk8t.jpg, https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195554/samples/landscapes/pexels-sindre-str%C3%B8m-958363_xm9qm9.jpg, https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195552/samples/landscapes/pexels-sindre-str%C3%B8m-955855_gslb87.jpg, https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195552/samples/landscapes/pexels-chait-goli-2666598_xrjnmq.jpg, https://res.cloudinary.com/diiu2j0fw/image/upload/v1654283914/samples/landscapes/pexels-photo-11739980_fsf6vd.jpg, https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195550/samples/landscapes/pexels-margerretta-902756_vguexu.jpg")
mont_review.marker = montroyal
mont_review.save

mont_review = Review.new(user: User.fourth, rating: 1, content: 'I was attacked by a racoon here!.', date: Date.yesterday, photos: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654194395/samples/landscapes/pexels-alex-andrews-821718_zjqiyx.jpg")
mont_review.marker = montroyal
mont_review.save

mont_review = Review.new(user: User.third, rating: 2, content: "I can't see the milky way there!", date: Date.today, photos: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654267278/samples/landscapes/pexels-kelly-leonard-5770637_oukksh.jpg")
mont_review.marker = montroyal
mont_review.save

mont_review = Review.new(user: sophie, rating: 3, content: "Good spot to see the moon.", date: Date.today, photos: photos_city.sample(3).join(", "))
mont_review.marker = montroyal
mont_review.save


puts "Mont-Royal created"
# http://api.positionstack.com/v1/forward?access_key=a5f3e8675d5ca91c470e9bbdcc288a62&country=CA&query=que
# http://api.positionstack.com/v1/

patrie = Marker.create!(
  title: "La Patrie",
  description: "Close to Mont Megantic, INTERNATIONAL DARK SKY RESERVE",
  latitude: 45.401821,
  longitude: -71.252853,
  user_id: user_list.sample.id,
  photo: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654193689/samples/landscapes/198260987_10159478328019914_5744544668368853112_n_n6vn2s.jpg"
)
patrie_review = Review.new(user: User.first, rating: 5, content: 'Did I see aliens?', date: Date.yesterday, photos: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654195552/samples/landscapes/pexels-dom-le-roy-4065333_fiq4n6.jpg, https://res.cloudinary.com/diiu2j0fw/image/upload/v1654265170/samples/landscapes/pexels-miriam-espacio-365625_lraduk.jpg, https://res.cloudinary.com/diiu2j0fw/image/upload/v1654265296/samples/landscapes/pexels-marek-piwnicki-8738454_am7dkz.jpg, https://res.cloudinary.com/diiu2j0fw/image/upload/v1654199906/samples/landscapes/pexels-dan-hadley-6017481_lgf5zl.jpg")
patrie_review.marker = patrie
patrie_review.save

patrie_review = Review.new(user: User.fifth, rating: 4, content: 'You can have a sit in the middle of that crop-circle to get great stars shots!', date: Date.today, photos: "https://res.cloudinary.com/diiu2j0fw/image/upload/v1654273108/samples/landscapes/pexels-photo-8703568_tuczcp.jpg, https://res.cloudinary.com/diiu2j0fw/image/upload/v1654273146/samples/landscapes/amazing-beautiful-breathtaking-clouds_zqojhy.jpg")
patrie_review.marker = patrie
patrie_review.save

patrie_review = Review.new(user: User.last, rating: 5, content: 'You can park your car at the field entrance. You can see the Milky Way with your naked eye!', date: Date.today, photos: photos_countryside.sample(5).join(", "))
patrie_review.marker = patrie
patrie_review.save

patrie_review = Review.new(user: linda, rating: 5, content: 'Definitiely my favorite spot in the area!', date: Date.today, photos: photos_countryside.sample(4).join(", "))
patrie_review.marker = patrie
patrie_review.save

puts "La Patrie created"
