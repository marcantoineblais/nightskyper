#  <div>
#   <% condition = jour[:conditions].split(",")[0]%>
#   <% if condition == "#{jour[:conditions]}" %>
#   <%= image_tag "images/weather/#{jour[:conditions]}"%>
#   <% end %>
#   <%= jour[:conditions]%>
#  </div>

def condition_image
  if
    drizzle.include?(jour[:conditions])
    image_tag "images/weather/Drizzle"
  elsif jour[:conditions] == "Duststorm"
    image_tag "images/weather/Drizzle"
  elsif jour[:conditions] == "Fog"
    image_tag "images/weather/Fog"
  elsif jour[:conditions] == "Funnel Cloud/Tornado"
    image_tag "images/weather/Tornado"
  elsif



end




# WEATHER CONDITION
drizzle = ["Drizzle", "Heavy Drizzle", "Light Drizzle", "Heavy Drizzle/Rain", "Light Drizzle/Rain"]
# type_2	Drizzle
# type_3	Heavy Drizzle
# type_4	Light Drizzle
# type_5	Heavy Drizzle/Rain
# type_6	Light Drizzle/Rain


# type_7	Duststorm
# type_8	Fog

# type_15	Funnel Cloud/Tornado

# type_16	Hail Showers
# type_17	Ice
# type_40	Hail

# type_9	Freezing Drizzle/Freezing Rain
# type_10	Heavy Freezing Drizzle/Freezing Rain
# type_11	Light Freezing Drizzle/Freezing Rain
# type_13	Heavy Freezing Rain
# type_14	Light Freezing Rain
# type_22	Heavy Rain And Snow
# type_23	Light Rain And Snow

# type_12	Freezing Fog
# type_1	Blowing Or Drifting Snow

# type_19	Mist
# type_20	Precipitation In Vicinity
# type_21	Rain
# type_24	Rain Showers
# type_25	Heavy Rain
# type_26	Light Rain

# type_27	Sky Coverage Decreasing
# type_28	Sky Coverage Increasing
# type_30	Smoke Or Haze
# type_41	Overcast
# type_42	Partially cloudy

# type_29	Sky Unchanged

# type_31	Snow
# type_32	Snow And Rain Showers
# type_33	Snow Showers
# type_34	Heavy Snow
# type_35	Light Snow

# type_36	Squalls

# type_18	Lightning Without Thunder
# type_37	Thunderstorm
# type_38	Thunderstorm Without Precipitation

# type_39	Diamond Dust (sparkles)

# type_43	Clear

# MOONPHASES
# case :moonphase
# when (O..0.11)
#   :moonphase = New moon
# when (O.12..0.24)
#   :moonphase = Waxing crescent
# when (0.25..0.36)
#   :moonphase = First quarter
# when (0.36..0.49)
#   :moonphase = Waxing gibbous
# when (0.50..0.62)
#   :moonphase = Full moon
# when (O.63..0.74)
#   :moonphase = Waning gibbous
# when (0.75..0.87)
#   :moonphase = Third quarter
# else (0.88..1)
#   :moonphase = New moon
# end
