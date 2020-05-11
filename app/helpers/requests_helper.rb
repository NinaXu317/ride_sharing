require './app/lib/matcher'

module RequestsHelper
  def match
    unmatched_availabilities = Availability.unmatched.to_a.map(&:serializable_hash)
    matcher = Matcher.new
    matcher.add_item_to_match(@request.id, @request.start_lat, @request.start_lon, @request.end_lat, @request.end_lon, @request.trip_time, @request.highest_price_to_pay)
    matcher.find_all_availabilities(unmatched_availabilities)
    matched_id = matcher.find_best_match
    if !matched_id.nil?
      modify_request(matched_id)
      modify_availability(matched_id)
    end
    return matched_id
  end

  def modify_request matched_id
    @request.matched_availability_id = matched_id
    @request.request_status = "waiting"
    @request.save
  end

  def modify_availability matched_id
    availability = Availability.find(matched_id)
    availability.matched_request_id = @request.id
    availability.availability_status = "waiting"
    availability.save
  end
end
