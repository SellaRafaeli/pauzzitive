def q_0
  if @text.split(' ').size > 1 
    stay('Sorry, didn\'t get that - can you try to answer with just one word?')
  else 
    goto(Q_PLEASE_PAUSE, craving: @text)
  end
end

def q_please_pause 
  if @text.include? 'done' 
    #send_fb_msg(@user_id, 'Good job!')
    goto(Q_0, msg: "Good job! When you want to do this again, just say 'hi' ;)")
  else
    stay('Hmm, I didn\'t get that... :( When you\'re done, please say "done" :)')
  end
end

def q_ask_question  
  if @text == '2' 
    goto(Q_RIGHT_ANSWER)
  else
    respond('Nope, wrong answer.')
  end
end












get '/bla' do
end