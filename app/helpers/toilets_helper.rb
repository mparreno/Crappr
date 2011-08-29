module ToiletsHelper
  def distanceize(km, to="m", display_type=true)
    case to
    when "m"
      new_distance = km.to_f * 1000
    when "km"
      new_distance = km.to_f
    else # m
      new_distance = km.to_f * 1000
    end
    to = "" unless display_type
    sprintf("%20.4g#{to}", new_distance)
  end
end
