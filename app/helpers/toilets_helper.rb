module ToiletsHelper
  def distanceize(km, to="m")
    new_distance = km.to_f * 1000
    sprintf("%20.4gm", new_distance)
  end
end
