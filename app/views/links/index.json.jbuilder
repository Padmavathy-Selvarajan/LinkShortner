
json.array! @links do |link|
  json.id link.id
  json.given_url link.given_url
  json.shortened_url link.shortened_url
  json.count Click.where(link_id: link.id).map(&:count).inject(:+)
  json.users do
  	json.array! link.users do |user|
	    json.email user.email
	    json.ip user.current_sign_in_ip
	    json.last_visited user.last_sign_in_at
  		json.user_clicks Click.find_by(link_id: link.id, user_id: user.id).count

    end
  end
end