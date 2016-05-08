module MealsHelper
  def distance_to_meal(current_location, meal)
    distance = Geocoder::Calculations.distance_between([meal.latitude, meal.longitude], current_location)
    if distance.to_s == "NaN"
      "No Location"
    else
      "Distance: #{distance}"
    end
  end
end
