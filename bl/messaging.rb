# get the data from the request
def parse_msg
  data = fb_parse_msg_data(params)
  @user_id, @text = data[:user_id], data[:text].to_s
  update_last_msg_time
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
  elsif t.in? 'restart', 'start'
    goto(START)  
  elsif t.in? 'state', 'info'
    user = $users.get(@user_id)
    respond(user.to_json)
  elsif Time.now - last_msg_time > 1.day
    goto(READY_TO_PAUZZ)
  end
rescue => e
end

def process_by_state
  @state = (params[:state] || get_state).downcase
  send(@state) if @state 
rescue => e 
  log_e(e)
end

def process_msg
  process_pre_state
  process_by_state
  goto(START) #if nothing else has registered
end

def goto(new_state, opts = {})
  set_state(new_state)
  state_response_text = opts[:msg] || state_response(new_state, opts)
  @rt = state_response_text #for tests
  respond(state_response_text)
end

def stay(text)
  respond(text)
end

def respond(text)
  user_state = get_state
  data = {user_id: @user_id, text: text}
  do_bg(:send_fb_text,data) 
  halt(200,{response: text, new_state:"#{user_state}", context: get_context})
end 

def handle_msg  
  parse_msg
  process_msg
end

get '/foo' do
  {a:1}
end