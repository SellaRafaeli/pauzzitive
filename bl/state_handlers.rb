# STATES

INTRO = :INTRO 
WHATS_YOUR_NAME = :WHATS_YOUR_NAME
READY_TO_PAUZZ = :READY_TO_PAUZZ 
GOODBYE_NO_PAUZZ = :GOODBYE_NO_PAUZZ 
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
#CONNECTION_NOTICED = :CONNECTION_NOTICED 
CONNECTION_DIDNT_NOTICE = :CONNECTION_DIDNT_NOTICE 
REFLECTION_AND_CHOICE = :REFLECTION_AND_CHOICE
START = INTRO

GOODBYE_SUCCESS = :GOODBYE_SUCCESS # successfully avoided craving 
ACT_ON_CRAVING_MAYBE  = :ACT_ON_CRAVING_MAYBE
ACT_ON_CRAVING_YES = :ACT_ON_CRAVING_YES
GOODBYE_FAILURE = :GOODBYE_FAILURE
ACT_ON_CRAVING_FEELING_BAD = :ACT_ON_CRAVING_FEELING_BAD

ALTERNATIVE_ACTION_MENU = :ALTERNATIVE_ACTION_MENU

#response upon ENTERING state
def state_response(state, opts = {})
  name = get_user_attr(:name)
  location = get_context['guessed_location']
  emotion  = get_context['emotion']
  craving  = get_context['craving'].to_s.downcase
  emotions_intensity_level = get_context[:emotions_intensity_level]
  craving_level            = get_context[:craving_level]
  user_time = (Time.now + get_user_attr(:tz_offset).hours).strftime("%H:%M")
  case state
  when START  
    "Hi, I'm Pauzz, your Pauzzitive friend... \n\nI'm here to help you with your cravings.\n\nLet's get started.\n\n1.We'll Pauzz and surf that crave.\n2.We'll figure out your triggers.\n3.A Pauzzitive alternative will come your way.\n\nAre you ready?"
  when WHATS_YOUR_NAME
    "First, we'll get to know each other.\nWhat's your name?"
  when READY_TO_PAUZZ    
    "Alright #{name},\n\nTime to Pauzz that craving. Are you ready?"
  when GOODBYE_NO_PAUZZ
    "OK! Perhaps another time....\n\n See you next time you're craving hits.\n\nLater..."
  when PAUZZ_BY_ACTION
    [
      "Just yawn...\nWhen you yawn, your brain reboots just like you would reboot your computer...",
      "Let's stretch.\nLift your hands up high and stretch your body.\nDoesn't it feel great to take a little Pauzz?",
      "Take 3 deep breaths\nInhale through the mouth\nExhale through the nose\nBreathing is the perfect Pauzz...\nDon't you think?",
      "Take a deep breath and count to 3\nHold your breath for 3 counts\nExhale for 3 counts\nFeels relaxing, right?",
      "Breathing is key\nBreathe in, breathe out\nLet's do this 10 times.\nFeels good, huh?",
      "Just count to 10.\n1,\n2,\n3,\n4,\nTake a deep breath...\n5,\n6,\n7,\n,8,\n9,\n10\n...\nNice and easy break, right?"
      ].sample
  when HIGH_FIVE
    "Awesome job!\nResisting temptation isn't easy, but you did it!\nGive yourself a high five!"
  when LOCATION
    "Let's move on...\nWhere are you now? Home, work, a restaurant?\nOr perhaps at some event, or just out and about?"
  when WHAT_CRAVING_NOW
    "What are you craving this time?"
  when HOW_BAD_CRAVING
    "On a scale of 1-10, how badly do you want #{craving}?"
  when WANT_CRAVING_LOW
    "Got it... OK...\nYou can surf that craving!"
  when WANT_CRAVING_HIGH
    "OK!\nWe've all been there, it's alright.\nLet's show that craving who's the boss."  
  when WHAT_EMOTION_EXPERIENCING
    "What feeling are you experiencing right now?"
  when EMOTIONS_INTENSITY
    "On a scale from 1-10, how intense is that feeling?"
  when EMOTIONS_INTENSITY_REFLECTION
    "Sorry you're feeling that way.\nlet's find a better way to deal with it. Ready?"
  when CONNECTION_EMOTIONS_CRAVING
    if (emotions_intensity_level > 5 && craving_level > 5) ||
       (emotions_intensity_level < 5 && craving_level < 5) 
      "Did you notice...\nthe connection between how badly you wanted your craving and the intensity of your emotion?"
    else
      "Did you notice the gap between the intensity of your craving and your feelings?"
    end
  when CONNECTION_DIDNT_NOTICE
    "#{name}... I justed wanted to share that there is often a connection... don't you think?"
  when REFLECTION_AND_CHOICE
    "It's now #{user_time}, you're #{guessed_location}, experiencing a bit of #{emotion}, and you have a craving for #{craving}. Are you going to eat it?"
  when GOODBYE_SUCCESS
    "Great job at Pauzzing!\nYou did it! Enjoy being Pauzzitive..."
  when ACT_ON_CRAVING_MAYBE
    "To eat or not to eat...?\nTry to think what you would tell your best friend in this situation.\nIt is sometimes easier to give the perfect advice to a friend.\nAre you ready for your Pauzzitive alternative?"
  when ACT_ON_CRAVING_YES
    "OK then... before we say goodbye,\nI'm going to ask you one last question...\nHow are you going to feel in an hour if you act on your craving?"
  when ACT_ON_CRAVING_FEELING_BAD
    'Sorry to hear that. Wanna try a Pauzzitive alternative?'
  when GOODBYE_FAILURE 
    "Well, honesty is important.\nAnd you did a great job pauzzing back there!\nRemember, I'm always here when you want to Pauzz your craving. See you next time!"
  when ALTERNATIVE_ACTION_MENU
    "Go do something alternative! We\'re done here, go back to start."
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
  profile   = get_user_profile(@user_id)  
  set_user_attr(:profile, profile)
  set_user_attr(:tz_offset, profile['timezone'].to_i * -1)
  set_user_attr(:name, @text)
  goto(READY_TO_PAUZZ)
end

def ready_to_pauzz  
  if @text == 'no'
    goto(GOODBYE_NO_PAUZZ) 
  else
    goto(PAUZZ_BY_ACTION)
  end
end

def goodbye_no_pauzz()                   goto(START) end
def pauzz_by_action()            goto(HIGH_FIVE) end
def high_five()                  goto(LOCATION) end

#http://localhost:9494/webhook?user_id=997788726969575&text=bla&state=location
def location()           
  set_context('location',guessed_location = guess_location(@text))
  goto(WHAT_CRAVING_NOW) 
end

def what_craving_now()           
  set_context('craving',@text)
  goto(HOW_BAD_CRAVING) 
end

def how_bad_craving
  craving_level = @text.to_i
  set_context(:craving_level, craving_level)
  if (craving_level > 5)
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

def emotions_intensity
  set_context('emotions_intensity_level',@text.to_i)
  goto(EMOTIONS_INTENSITY_REFLECTION) 
end

def emotions_intensity_reflection() goto(CONNECTION_EMOTIONS_CRAVING) end

def connection_emotions_craving() 
  if (@text == 'no') 
    goto(CONNECTION_DIDNT_NOTICE)
  else 
    goto(REFLECTION_AND_CHOICE)
  end
end

def connection_didnt_notice() goto(REFLECTION_AND_CHOICE) end

def reflection_and_choice
  if (@text == 'no') 
    goto(GOODBYE_SUCCESS)
  elsif (@text == 'maybe') 
    goto(ACT_ON_CRAVING_MAYBE)
  else #yes
    goto(ACT_ON_CRAVING_YES)
  end
end

def goodbye_success() goto(START) end
def goodbye_failure() goto(START) end

def act_on_craving_yes
  if (@text == 'good') 
    goto(GOODBYE_FAILURE)
  else 
    goto(ACT_ON_CRAVING_FEELING_BAD)
  end
end

def act_on_craving_feeling_bad
  if (@text == 'no') 
    goto(GOODBYE_FAILURE)    
  else
    goto(ALTERNATIVE_ACTION_MENU)
  end
end

def act_on_craving_maybe 
  goto(ALTERNATIVE_ACTION_MENU)
end

def alternative_action_menu
  goto(START)
end

get '/bla' do {refresh: true} end