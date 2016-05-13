def http_post(route, data = {}, headers = {})
  RestClient.post(route, data, headers)
end

def http_post_json(route, data = {}, headers = {})
  headers.merge!({content_type: :json, accept: :json})
  http_post(route, data.to_json, headers)
end