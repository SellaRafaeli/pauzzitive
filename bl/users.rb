def set_user_last_pauzz_msg(user_id, message_name)
  $users.update_id(user_id, {last_pauzz_msg: message_name}, {upsert: true}) rescue nil
end

def get_user_last_pauzz_msg(user_id)
  $users.get(user_id)['last_pauzz_msg'] rescue nil
end