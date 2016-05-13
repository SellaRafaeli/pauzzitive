def handle_msg_wrapper
  print_msg
  ## TODO: check if verification token is legit
  return params['hub.challenge'] if params['hub.challenge']
  handle_msg
rescue => e
  {msg: "some error occurred"}
end

def handle_msg
  data = fb_msg_data(params)
  user_id, text = data[:user_id], data[:text]

  response_msg = "I got: #{text}. In reverse it is: #{text.reverse}"
  response_msg = LiterateRandomizer.sentence if text == 'random' rescue 'oopsie'
  response_msg = kinky_text if text == 'test'
  response_msg = '0.0.1' if text == 'version'
  send_fb_msg(user_id, response_msg)
end

