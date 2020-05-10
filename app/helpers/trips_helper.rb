module TripsHelper
  def find_trip trips, res
    trips.each do |t|
      if t.availability_id == -1
        # if driver accepts request by using accept ride button
        res << [t.request_id, "request", t.id]
      else
        # if driver confirms rider's request
        res << [t.availability_id, "availability", t.id]
      end
    end
    return res
  end
end