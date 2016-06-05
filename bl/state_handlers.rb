# STATES

INTRO = :INTRO 
WHATS_YOUR_NAME = :WHATS_YOUR_NAME
READY_TO_PAUZZ = :READY_TO_PAUZZ 
GOODBYE1 = :GOODBYE1 
PAUZZ_BY_ACTION = :PAUZZ_BY_ACTION 
HIGH_FIVE = :HIGH_FIVE 
LOCATION = :LOCATION 
WHAT_CRAVING_NOW = :WHAT_CRAVING_NOW 
HOW_BAD_CRAVING = :HOW_BAD_CRAVING 
WANT_CRAVING_LOW = :WANT_CRAVING_LOW 
WANT_CRAVING_HIGH = :WANT_CRAVING_HIGH 
WHAT_EMOTION_EXPERIENCING = :WHAT_EMOTION_EXPERIENCING 
EMOTIONS_INTENSITY = :EMOTIONS_INTENSITY 
EMOTIONS_INTENSITY_REFLECTION = :EMOTIONS_INTENSITY_REFLECTION 
CONNECTION_EMOTIONS_CRAVING = :CONNECTION_EMOTIONS_CRAVING 
CONNECTION_NOTICED = :CONNECTION_NOTICED 
CONNECTION_DIDNT_NOTICE = :CONNECTION_DIDNT_NOTICE 

START = INTRO

#response upon ENTERING state
def state_response(state, opts = {})
  name = get_user_attr(:name)
  location = get_context['location']
  emotion  = get_context['emotion']
  craving  = get_context['craving']

  case state
  when START  
    "Hi, I'm Pauzz, your Pauzzitive friend... \n\nI'm here to help you with your cravings.\n\nLet's get started.\n\n1.We'll Pauzz and surf that crave.\n2.We'll figure out your triggers.\n3.A Pauzzitive alternative will come your way.\n\nAre you ready?"
  when WHATS_YOUR_NAME
    "What's your name?"
  when READY_TO_PAUZZ    
    "Alright #{name},\n\nTime to Pauzz that craving. Are you ready?"
  when GOODBYE1
    "OK! Perhaps another time....\n\n See you next time you're craving hits.\n\nLater..."
  when PAUZZ_BY_ACTION
    [
      "Just yawn...\nWhen you yawn, your brain reboots just like you would reboot your computer...",
      "Let's stretch.\nLift your hands up high and stretch your body.\nDoesn't it feel great to take a little Pauzz?",
      "Take 3 deep breaths\nInhale through the mouth\nExhale through the nose\nBreathing is the perfect Pauzz...\nDon't you think?",
      "Take a deep breath and count to 3\nHold your breath for 3 counts\nExhale for 3 counts\nFeels relaxing, right?",
      "Breathing is key\nBreathe in, breathe out\nLet's do this 10 times.\nFeels good, huh?",
      "Just count to 10.\n1, 2, 3...\nNice and easy break, right?"
      ].sample
  when HIGH_FIVE
    "Awesome job!\nResisting temptation isn't easy, but you did it!\nGive yourself a high five!"
  when LOCATION
    "Let's move on...\nWhere are you now? Home, work, or perhaps at some event?"
  when WHAT_CRAVING_NOW
    "What are you craving this time?"
  when HOW_BAD_CRAVING
    "On a scale of 1-10, how badly do you want that craving?"
  when WANT_CRAVING_LOW
    "Got it... OK...\nYou can surf that craving!"
  when WANT_CRAVING_HIGH
    "OK!\nWe've all been there, it's alright.\nLet's show that craving who's the boss."  
  when WHAT_EMOTION_EXPERIENCING
    "What feeling are you experiencing right now?"
  when EMOTIONS_INTENSITY
    "On a scale from 1-10, how intense if that feeling?"
  when EMOTIONS_INTENSITY_REFLECTION
    "Sorry you're feeling that way.\nlet's find a better way to deal with it. Ready?"
  when CONNECTION_EMOTIONS_CRAVING
    "Did you notice...\nthe connection between how badly you wanted your craving and the intensity of your emotion?"
  when CONNECTION_NOTICED
    "#{name}... I justed wanted to share that there is often a connection... don't you think?"
  when CONNECTION_DIDNT_NOTICE
    "It's now #{Time.now}, you're at #{location}, experiencing #{emotion}, and you have a craving for #{craving}. Are you going to eat it?"
  else 
    "missing text for state: #{state.to_s}"
  end
end

# handler for LEAVING state, based on input
def intro
  reset_context
  goto(WHATS_YOUR_NAME)
end

def whats_your_name
  set_user_attr(:name, @text)
  goto(READY_TO_PAUZZ)
end

def ready_to_pauzz
  if @text == 'no'
    goto(GOODBYE1) 
  else
    goto(PAUZZ_BY_ACTION)
  end
end

def goodbye1()                   goto(START) end
def pauzz_by_action()            goto(HIGH_FIVE) end
def high_five()                  goto(LOCATION) end

def location()           
  set_context('location',@text)
  goto(WHAT_CRAVING_NOW) 
end

def what_craving_now()           
  set_context('craving',@text)
  goto(HOW_BAD_CRAVING) 
end

def how_bad_craving
  if (@text.to_i > 5)
    goto(WANT_CRAVING_HIGH)
  else
    goto(WANT_CRAVING_LOW)
  end
end

def want_craving_low ()             goto(WHAT_EMOTION_EXPERIENCING) end
def want_craving_high()             goto(WHAT_EMOTION_EXPERIENCING) end

def what_emotion_experiencing
  set_context('emotion',@text)
  goto(EMOTIONS_INTENSITY) 
end

def emotions_intensity()            goto(EMOTIONS_INTENSITY_REFLECTION) end
def emotions_intensity_reflection() goto(CONNECTION_EMOTIONS_CRAVING) end

def connection_emotions_craving() 
  if (@text == 'no') 
    goto(CONNECTION_NOTICED) 
  else 
    goto(CONNECTION_DIDNT_NOTICE)
  end
end

def connection_noticed() goto(START) end
def connection_didnt_notice() goto(START) end

get '/bla' do {refresh: true} end