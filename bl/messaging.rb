# STATES
Q_0 = :Q_0
Q_ASK_QUESTION = :Q_ASK_QUESTION
Q_RIGHT_ANSWER = :Q_RIGHT_ANSWER
Q_WRONG_ANSWER = :Q_WRONG_ANSWER
Q_PLEASE_PAUSE = :Q_PLEASE_PAUSE

def get_state_text(state, opts = {})
  case state
  when Q_0 
    'What are you craving right now?'
  when Q_ASK_QUESTION
    'How much is 1+1?'
  when Q_PLEASE_PAUSE
    "Sorry to hear you\'re craving #{opts[:craving]}. Please count to 17. When you\'re finished, say 'done'."
  else 
    "I really don't know what to say."
  end
end

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
  elsif t == 'version'
    respond('0.0.1.1')
  elsif t == 'kinky'
    respond(kinky_text)  
  elsif t.include? "time"
    respond('It is currently '+Time.now.strftime('%H:%M'))
  elsif t.in? 'restart', 'begin', 'hi', 'help', 'hey'
    send_fb_text(@user_id, 'OK, let\'s start at the beginning.')
    goto(Q_0)    
  elsif t.include_any? 'ask me', 'question'
    goto(Q_ASK_QUESTION)      
  elsif t.include_any? 'state'
    user = $users.get(@user_id)
    respond(user.to_json)
  end
rescue => e
end

def process_by_state
  @state = get_state.downcase
  send(@state) if @state 
rescue => e 
  log_e(e)
end

def process_msg
  process_pre_state
  process_by_state
  goto(Q_0)    
end

def goto(new_state, opts = {})
  set_state(new_state)
  state_text = opts[:msg] || get_state_text(new_state, opts)
  respond(state_text)
end

def stay(text)
  respond(text)
end

def respond(text)
  user_state = get_state
  send_fb_text(@user_id, text) 
  halt(200,{response: "#{text}", new_state:"#{user_state}"})
end 

def handle_msg  
  parse_msg
  process_msg
end

get '/foo' do
  {a:1}
end