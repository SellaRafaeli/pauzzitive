# pauzzitive
FB_PAGE_TOKEN = ENV['FB_PAGE_TOKEN']
FB_PAGE_ID    = 492664237595026
FB_MSGING_ROUTE      = 'https://graph.facebook.com/v2.6/me/messages'
FB_PAGE_ROUTE        = "https://graph.facebook.com/v2.6/#{FB_PAGE_ID}/thread_settings?access_token=#{FB_PAGE_TOKEN}"
SELLA_USER_ID = '997788726969575'

# send



def send_fb_msg(user_id, message_data)
  #data  = {recipient: {id: user_id}, message: message_data}
  data  = {recipient: {id: user_id}, message: message_data}
  route = FB_MSGING_ROUTE+"?access_token=#{FB_PAGE_TOKEN}"
  http_post_json(route, data)  
end

# send_fb_msg_options([ opt1, opt2])
# each opt has title and url+type=web_url or payload+type=postback.
def send_fb_buttons(user_id, msg, btns_arr) 
  btns = btns_arr[0..2] #fb allows 3 opts
  data = { "attachment":{
      "type":"template",
      "payload":{
        "template_type":"button",
        "text": msg,
        "buttons": btns
      }}}
  send_fb_msg(user_id, data)
end

def set_welcome_screen
  structured = { "attachment":{
          "type":"template",
          "payload":{ "template_type":"generic",
            "elements":[
              { "title":"What are you craving right now?",
                "item_url":"https://www.pauzz.com",
                "image_url":"https://www.petersbowlerhats.com/img/hat.jpeg",
                "subtitle":"We're here to help.",
                "buttons":[ {"type":"web_url", "title":"View Website", "url":"https://www.petersbowlerhats.com"}, 
                  {"type":"postback", "title":"Start Chatting", "payload":"DEVELOPER_DEFINED_PAYLOAD"} ] } ] }
              }}
  text = {text: "Hey there. We're here to help you with your craving. Type 'hi' to start." }
  
  data = {"setting_type":"call_to_actions", "thread_state":"new_thread", 
          "call_to_actions":[{ "message": text}]}
  http_post_json(FB_PAGE_ROUTE, data)   
end

def send_fb_text(user_id, text)
  set_user_last_pauzz_msg(user_id,)
  send_fb_msg(user_id, {text: text})
end

## get 
def fb_parse_msg_data(data)
  user_id = data[:entry][0][:messaging][0][:sender][:id]
  text    = data[:entry][0][:messaging][0][:message][:text] rescue nil
  payload = data[:entry][0][:messaging][0][:postback][:payload] rescue nil

  {user_id: user_id, text: text, payload: payload}
end

EXAMPLE_FB_PAYLOAD = {
  "object": "page",
  "entry": [
    {
      "id": 492664237595026,
      "time": 1462900319057,
      "messaging": [
        {
          "sender": {
            "id": 997788726969575
          },
          "recipient": {
            "id": 492664237595026
          },
          "timestamp": 1462900318917,
          "message": {
            "mid": "mid.1462900318906:acfb67c815f7160722",
            "seq": 15,
            "text": "hello14"
          }
        }
      ]
    }
  ]
}

def test_fb_text
  send_fb_text(SELLA_USER_ID, 'hello world 3')
end

def test_fb_buttons
  btns = [ {"type":"web_url", "url":"https://petersapparel.parseapp.com", "title":"Show Website"},
           {"type":"postback", "title":"Start Chatting 1", "payload":"USER_DEFINED_PAYLOAD 1 "}, 
           {"type":"postback", "title":"Start Chatting 2", "payload":"USER_DEFINED_PAYLOAD 2"} ] 
  msg  = 'Please pick an option.'
  send_fb_buttons(SELLA_USER_ID, msg, btns)
end
