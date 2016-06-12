# state 
def set_state(state_name)
  $users.update_id(@user_id, {state: state_name}, {upsert: true}) rescue nil
end

def get_state
  (state = ($users.get(@user_id) || {})['state']) ? state.to_sym : nil rescue nil
end

# attributes
def set_user_attr(attr, val)
  $users.update_id(@user_id, {attr => val}, {upsert: true}) rescue nil
end

def get_user_attr(attr)
  ($users.get(@user_id) || {})[attr.to_s]
end

# context
def set_context(field, val)
  $users.update_id(@user_id, {"context.#{field}" => val}, {upsert: true}) rescue nil
end

def reset_context
  $users.update_id(@user_id, {context: {}}, {upsert: true}) rescue nil
end

def get_context 
  (context = ($users.get(@user_id) || {})['context'] || {}) rescue {}
end

# methods 
def update_last_msg_time
  prev_msg_time = get_user_attr('cur_msg_time') # temp <- cur_msg_time
  set_user_attr('last_msg_time',prev_msg_time) if prev_msg_time # last_msg_time <- temp
  set_user_attr('cur_msg_time',Time.now) # cur_msg_time <- now
end

def last_msg_time
  get_user_attr('last_msg_time')
end