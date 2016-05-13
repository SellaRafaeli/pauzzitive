def set_state(state_name)
  $users.update_id(@user_id, {state: state_name}, {upsert: true}) rescue nil
end

def get_state
  (state = ($users.get(@user_id) || {})['state']) ? state.to_sym : nil rescue nil
end