def set_state(state_name)
  $users.update_id(@user_id, {state: state_name}, {upsert: true}) rescue nil
end

def get_state
  (state = ($users.get(@user_id) || {})['state']) ? state.to_sym : nil rescue nil
end

def set_user_attr(attr, val)
  $users.update_id(@user_id, {attr => val}, {upsert: true}) rescue nil
end

def get_user_attr(attr)
  ($users.get(@user_id) || {})[attr.to_s]
end