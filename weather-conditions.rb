class WeatherCondition
  def initialize
    @conditions = {
      ["Drizzle", "Heavy Drizzle", "Light Drizzle", "Heavy Drizzle/Rain", "Light Drizzle/Rain"] => "weather/Drizzle",
      ["Partially cloudy", "Duststorm", "Fog"] => "weather/Fog",
      ["Funnel Cloud/Tornado"] => "weather/Tornado",
      ["Hail Showers", "Ice", "Hail"] => "weather/Ice",
      ["Freezing Drizzle/Freezing Rain", "Heavy Freezing Drizzle/Freezing Rain", "Light Freezing Drizzle/Freezing Rain", "Heavy Freezing Rain", "Light Freezing Rain", "Heavy Rain And Snow", "Light Rain And Snow"] => "weather/Freezing_snow_rain",
      ["Mist", "Precipitation In Vicinity", "Rain", "Rain Showers", "Heavy Rain", "Light Rain"] => "weather/Rain",
      ["Sky Coverage Decreasing", "Sky Coverage Increasing", "Smoke Or Haze", "Overcast", "Partially cloudy"] => "weather/Cloudy",
      ["Blowing Or Drifting Snow", "Freezing Fog", "Snow", "Snow And Rain Showers", "Snow Showers", "Heavy Snow", "Light Snow"] => "weather/Snow",
      ["Squalls"] => "weather/Squalls",
      ["Lightning Without Thunder", "Thunderstorm", "Thunderstorm Without Precipitation"] => "weather/Thunder",
      ["Diamond Dust"] => "weather/Diamond_dust",
      ["Clear"] => "weather/Clear",
      (0..0.11) => "moonphase/New_Moon",
      (0.12..0.24) => "moonphase/Waxing_crescent",
      (0.25..0.36) => "moonphase/First_quarter",
      (0.37..0.49) => "moonphase/Waxing_gibbous",
      (0.50..0.62) => "moonphase/Full_moon",
      (0.63..0.74) => "moonphase/Waning_gibbous",
      (0.75..0.87) => "moonphase/Third_quarter",
      (0.88..1) => "moonphase/New_moon1"
    }

    @moonphase = {
      (0..0.11) => "New Moon",
      (0.12..0.24) => "Waxing crescent",
      (0.25..0.36) => "First quarter",
      (0.37..0.49) => "Waxing gibbous",
      (0.50..0.62) => "Full moon",
      (0.63..0.74) => "Waning gibbous",
      (0.75..0.87) => "Third quarter",
      (0.88..1) => "New moon"
    }
  end

  def get_url(condition)
    result = @conditions.find { |key, value| key.include?(condition) }
    result[1]
  end

  def get_moonphase(phase)
   result = @moonphase.find { |key, value| key.include?(phase) }
   result[1]
  end
end

#  WEATHER CONDITION

# drizzle = ["Drizzle", "Heavy Drizzle", "Light Drizzle", "Heavy Drizzle/Rain", "Light Drizzle/Rain"]
#  type_2	Drizzle
#  type_3	Heavy Drizzle
#  type_4	Light Drizzle
#  type_5	Heavy Drizzle/Rain
#  type_6	Light Drizzle/Rain

# fog = ["Duststorm", "Fog"]
#  type_7	Duststorm
#  type_8	Fog

# tornado = "Funnel Cloud/Tornado" **
#  type_15	Funnel Cloud/Tornado

# ice = ["Hail Showers", "Ice", "Hail"]
#  type_16	Hail Showers
#  type_17	Ice
#  type_40	Hail

# freezing_snow_rain = ["Freezing Drizzle/Freezing Rain", "Heavy Freezing Drizzle/Freezing Rain", "Light Freezing Drizzle/Freezing Rain", "Heavy Freezing Rain", "Light Freezing Rain", "Heavy Rain And Snow", "Light Rain And Snow"]
#  type_9	Freezing Drizzle/Freezing Rain
#  type_10	Heavy Freezing Drizzle/Freezing Rain
#  type_11	Light Freezing Drizzle/Freezing Rain
#  type_13	Heavy Freezing Rain
#  type_14	Light Freezing Rain
#  type_22	Heavy Rain And Snow
#  type_23	Light Rain And Snow

# rain = ["Mist", "Precipitation In Vicinity", "Rain", "Rain Showers", "Heavy Rain", "Light Rain"]
#  type_19	Mist
#  type_20	Precipitation In Vicinity
#  type_21	Rain
#  type_24	Rain Showers
#  type_25	Heavy Rain
#  type_26	Light Rain

# cloudy = ["Sky Coverage Decreasing", "Sky Coverage Increasing", "Smoke Or Haze", "Overcast", "Partially cloudy"]
#  type_27	Sky Coverage Decreasing
#  type_28	Sky Coverage Increasing
#  type_30	Smoke Or Haze
#  type_41	Overcast
#  type_42	Partially cloudy
#  type_29	Sky Unchanged

# snow = ["Blowing Or Drifting Snow", "Freezing Fog", "Snow", "Snow And Rain Showers", "Snow Showers", "Heavy Snow", "Light Snow"]
#  type_1	Blowing Or Drifting Snow
#  type_12	Freezing Fog
#  type_31	Snow
#  type_32	Snow And Rain Showers
#  type_33	Snow Showers
#  type_34	Heavy Snow
#  type_35	Light Snow

# squalls = "Squalls" **
#  type_36	Squalls

# thunder = ["Lightning Without Thunder", "Thunderstorm", "Thunderstorm Without Precipitation"]
#  type_18	Lightning Without Thunder
#  type_37	Thunderstorm
#  type_38	Thunderstorm Without Precipitation

# diamond_dust = ["Diamond Dust"] **
#  type_39	Diamond Dust (sparkles)

# sunny = ["Clear"]
#  type_43	Clear

# # MOONPHASES
# case :moonphase
#  when (O..0.11)
#    :moonphase = New moon
#  when (O.12..0.24)
#    :moonphase = Waxing crescent
#  when (0.25..0.36)
#    :moonphase = First quarter
#  when (0.36..0.49)
#    :moonphase = Waxing gibbous
#  when (0.50..0.62)
#    :moonphase = Full moon
#  when (O.63..0.74)
#    :moonphase = Waning gibbous
#  when (0.75..0.87)
#    :moonphase = Third quarter
#  else (0.88..1)
#    :moonphase = New moon
#  end
