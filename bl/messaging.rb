def handle_msg_wrapper
  print_msg
  ## TODO: check if verification token is legit
  return params['hub.challenge'] if params['hub.challenge']
  handle_msg
rescue => e
  {msg: "some error occurred"}
end

def handle_msg

  data = fb_parse_msg_data(params)
  user_id, text = data[:user_id], data[:text].to_s

  send_fb_text(user_id, 'pong') if text == 'ping'

  lm = last_message = get_user_last_pauzz_msg(user_id)
  new_lm = nil
  #default
  response_msg = "I got: #{text}. In reverse it is: #{text.reverse}"
  
  if text == 'hi' 
    new_lm       = :what_you_craving
    response_msg = 'What are you craving?'  
  elsif lm == :what_you_craving
    if text.split(' ').size == 1
      new_lm       = :sorry_youre_craving
      response_msg = "Oh, I'm sorry to hear you're craving "+text.
    else 
      response_msg = 'Sorry, what are you craving? Please use a single word.'
    end
  end

  #randoms
  response_msg = LiterateRandomizer.sentence if text == 'random' rescue 'oopsie'
  response_msg = kinky_text if text == 'test'
  response_msg = '0.0.1' if text == 'version'  

  set_user_last_pauzz_msg(user_id, new_lm)
  send_fb_text(user_id, response_msg)
end

get '/foo' do
  foo
end