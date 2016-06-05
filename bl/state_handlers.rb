# STATES

INTRO = :INTRO 
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
  case state
  when START  
    'Hi! Welcome, what is your name?'
  when READY_TO_PAUZZ
    "Alright #{opts[:name]}, are you ready to Pauzz?"
  when GOODBYE1
    "OK, see you later!"
  when PAUZZ_BY_ACTION
    "Ok, try yawning for five seconds... feels good huh?"
  when HIGH_FIVE
    "Good job! High five!"
  when LOCATION
    "Where are you now?"
  when WHAT_CRAVING_NOW
    "What are you craving now?"
  when HOW_BAD_CRAVING
    "How bad are you craving it?"
  when WANT_CRAVING_LOW
    "That's not too bad - you can surf that craving!"
  when WANT_CRAVING_HIGH
    "You want it bad! We've all been there, it's alright."  
  when WHAT_EMOTION_EXPERIENCING
    "What emotion are you experiencing?"
  when EMOTIONS_INTENSITY
    "How intense is the emotion?"
  when EMOTIONS_INTENSITY_REFLECTION
    "Sorry you're feeling that way, let's find a better way to deal with it. Ready?"
  when CONNECTION_EMOTIONS_CRAVING
    "Did you notice the connection between how badly you wanted your craing and the intensity of your emotion?"
  when CONNECTION_NOTICED
    "I justed wanted to share that there is often a connection... don't you think?"
  when CONNECTION_DIDNT_NOTICE
    "It's now <time>, you're at <location>, experiencing <emotion>, and you have a craving for <craving>. Are you going to eat it?"
  else 
    "missing text for state: #{state.to_s}"
  end
end

# handler for LEAVING state, based on input
def intro
  goto(READY_TO_PAUZZ, name: @text)
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
def location()                   goto(WHAT_CRAVING_NOW) end
def what_craving_now()           goto(HOW_BAD_CRAVING) end

def how_bad_craving
  if (@text.to_i > 5)
    goto(WANT_CRAVING_HIGH)
  else
    goto(WANT_CRAVING_LOW)
  end
end

def want_craving_low ()             goto(WHAT_EMOTION_EXPERIENCING) end
def want_craving_high()             goto(WHAT_EMOTION_EXPERIENCING) end
def what_emotion_experiencing()     goto(EMOTIONS_INTENSITY) end
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