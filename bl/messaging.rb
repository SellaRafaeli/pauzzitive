# STATES
Q_0 = :Q_0
Q_ASK_QUESTION = :Q_ASK_QUESTION

# get the data from the request
def parse_msg
  data = fb_parse_msg_data(params)
  @user_id, @text = data[:user_id], data[:text].to_s
end

# processing that is unrelated to current state, just by the input.
# may affect state change, may not. 
def process_pre_state 
  t = @text
  if t == 'ping' 
    respond('pong')
  elsif t.include? 'restart'
    set_state(Q_0)
    respond('How much is 1+1?')
  elsif t.include? 'ask me'
    
    respond('How much is 1+1?', Q_ASK_QUESTION)
  elsif t.include? "time"
    respond('It is currently '+Time.now.strftime('%H:%M'))
  end
end

def process_by_state
  @state = get_state
end

def process_msg
  process_pre_state
  process_by_state
  process_post_state
end

def update_state

end


def respond(text, new_state = nil)
  set_state(new_state) if new_state
  send_fb_text(@user_id, text)
end 

def handle_msg
  parse_msg
  process_msg
  update_state
  respond_to_msg
  #get data
  

  #figure out what to do
  handle_before_state(text)

  lm = last_message = get_user_last_pauzz_msg(user_id)
  new_lm = nil
  #default
  response_msg = "I got: #{text}. In reverse it is: #{text.reverse}"
  
  if text == 'hi' 
    new_lm       = 'what_you_craving'
    response_msg = 'What are you craving?'  
  elsif lm == 'what_you_craving'
    if text.split(' ').size == 1
      new_lm       = :sorry_youre_craving
      response_msg = "Oh, I'm sorry to hear you're craving "+text
    else 
      new_lm       = 'what_you_craving'
      response_msg = 'Sorry, what are you craving? Please use a single word.'
    end
  end

  #randoms
  response_msg = LiterateRandomizer.sentence if text == 'random' rescue 'oopsie'
  response_msg = kinky_text if text == 'test'
  response_msg = '0.0.1' if text == 'version'  

  #update state

  #respond
  set_user_last_pauzz_msg(user_id, new_lm)
  send_fb_text(user_id, response_msg)
end

def handle_before_state(text)

end


def foo 
  @foo = 789
end

def bar 
  {res: @foo}
end

get '/foo' do
  z = 20
  return 'foo'
end