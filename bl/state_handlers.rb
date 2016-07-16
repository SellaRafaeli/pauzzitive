# STATES

INTRO = :INTRO 
START = INTRO
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
GOODBYE_SUCCESS = :GOODBYE_SUCCESS # successfully avoided craving 
ACT_ON_CRAVING_MAYBE  = :ACT_ON_CRAVING_MAYBE
ACT_ON_CRAVING_YES = :ACT_ON_CRAVING_YES
GOODBYE_FAILURE = :GOODBYE_FAILURE
ACT_ON_CRAVING_FEELING_BAD = :ACT_ON_CRAVING_FEELING_BAD

ALTERNATIVE_ACTION_MENU = :ALTERNATIVE_ACTION_MENU

# mindful
MANTRA              = :MANTRA
MINDFUL_STATEMENT   = :MINDFUL_STATEMENT
INSPIRATIONAL_QUOTE = :INSPIRATIONAL_QUOTE
MINDFUL_GOODBYE     = :MINDFUL_GOODBYE

# creative
BE_CREATIVE      = :BE_CREATIVE
CREATIVE_GOODBYE = :CREATIVE_GOODBYE

# get moving 
GET_MOVING1   = :GET_MOVING1
GET_MOVING2   = :GET_MOVING2
STRETCH_ARMS  = :STRETCH_ARMS
JUMPING_JACKS = :JUMPING_JACKS
BUTT_CLENCH   = :BUTT_CLENCH
WALK_100_STEPS= :WALK_100_STEPS
GET_MOVING_GOODBYE = :GET_MOVING_GOODBYE

#response upon ENTERING state
def state_response(state, opts = {})
  name = get_user_attr(:name)
  guessed_location = get_context[:location]
  emotion  = get_context['emotion']
  craving  = get_context['craving'].to_s.downcase
  emotions_intensity_level = get_context[:emotions_intensity_level]
  craving_level            = get_context[:craving_level]
  user_time = (Time.now + get_user_attr(:tz_offset).hours).strftime("%H:%M") rescue 'the middle of the day'
  case state
  when START  
    [
      "Hi, I'm Pauzz, your Pauzzitive friend... \n\n",
      "Hey there! I'm Pauzz, I'll be your Pauzzitive friend. ;) \n\n",
      "Hi! I'll be your Pauzzitive friend. You can call me Pauzz.\n\n",
      "Hello. My name is Pauzz.\n\n"
    ].sample + 
    [
      "I'm here to help you with your cravings.\n\n",
      "I can help you with your cravings.\n\n",
      "I'd like to help you with your cravings.\n\n",
      "I am here to help with cravings! :)\n\n"
    ].sample + 
    [
      "Let's get started.\n\n",
      "Let's start.\n\n"
    ].sample +       
    [
      "1.We'll Pauzz and surf that crave.\n",
      "1.We'll 'Pauzz' the craving.\n",
    ].sample + 
    [
      "2.We'll figure out your triggers.\n",
      "2.We'll understand what your triggers are.\n"
    ].sample + 
    [
      "3.A Pauzzitive alternative will come your way.\n\n",
      "3.We'll send you some Pauzzitive alternative.\n\n"
    ].sample + 
    "Are you ready?"
  when WHATS_YOUR_NAME
    [
      "First, we'll get to know each other.\nWhat's your name?",
      "First let's get acquainted. ;) How should I call you?",
      "First of all - nice to meet you. What is your name?",
      "First thing's first - what's your name? :)",
      "First thing... how should I call you?"
    ].sample
  when READY_TO_PAUZZ    
    [
      "Alright #{name},\n\nTime to Pauzz that craving. Are you ready?",
      "OK #{name}...\n\nTime to PAUZZ your craving. Ready?",
      "Nice to meet you, #{name}. Are you ready to Pauzz your craving?",
      "Well #{name} - nice to make your acquaintance. Shall we proceed to Pauzzing your craving? :)"
    ].sample
  when GOODBYE_NO_PAUZZ
    "OK! Perhaps another time....\n\n See you next time you're craving hits.\n\nLater..."
  when PAUZZ_BY_ACTION
    [
      "Just yawn...\nWhen you yawn, your brain reboots just like you would reboot your computer...",
      "Let's stretch.\nLift your hands up high and stretch your body.\nDoesn't it feel great to take a little Pauzz?",
      "Take 3 deep breaths\n...\nInhale through the mouth...\n...\n...\nExhale through the nose\n...\n...\n...\nBreathing is the perfect Pauzz...\nDon't you think?",
      "Take a deep breath and count to 3\n...\n...\n...\nHold your breath for 3 counts\n...\n...\n...\nExhale for 3 counts\n...\n...\n...\nFeels relaxing, right?",
      "Breathing is key\nBreathe in, breathe out\nLet's do this 10 times.\nFeels good, huh?",
      "Just count to 10.\n1,\n2,\n3,\n4,\nTake a deep breath...\n5,\n6,\n7,\n,8,\n9,\n10\n...\nNice and easy break, right?"
      ].sample
  when HIGH_FIVE
    [
      "Awesome job!\nResisting temptation isn't easy, but you did it!\nGive yourself a high five!",
      "Good job!\bIt isn't easy to resist temptation. But you did it!\nGood job! Give me a high five or thumbs up!",
      "I'm proud of you. You resisted the temptation! Give me a high five (or a thumbs up ;) )..",
      "Congrats! That was great - you did not give in to temptation! High five!"
    ].sample
  when LOCATION
    ["Let's continue...\nWhere are you now? Home, work, a restaurant?\nOr perhaps at some event, or just out and about?",
      "So, where are you now?\nAt a restaurant, some event? Perhaps at home or at work?",
      "Tell me where you are - at home or at a restaurant or at an event?\n Or perhaps at work?",
      "Where are you right now?\nI wonder if you're at work or at an event. Or perhaps at home. Or just out..?"
      ].sample
  when WHAT_CRAVING_NOW
    [
      "What are you craving right now?",
      "What's your craving?",
      "What are you feeling like right now?\n What are you craving?",
      "What do you feel like you're craving right now?"
    ].sample
  when HOW_BAD_CRAVING
    [
      "On a scale of 1-10, how badly do you want the #{craving}?",
      "How bad do you want the #{craving}? From 1-10.",
      "From 1-10, how much are you craving the #{craving}?",
      "How bad do you feel like having the #{craving}?\nSay from 1 (the least) to 10 (the most)."
    ].sample
  when WANT_CRAVING_LOW
    [
      "Got it... OK...\nYou can surf that craving!",
      "I see. Well, you can handle that.",
      "Ah OK. You can manage it!",
      "Well, you can beat that!"
    ].sample
  when WANT_CRAVING_HIGH
    [
      "OK!\nWe've all been there, it's alright.\nLet's show that craving who's the boss.",
      "Well, I know what you mean.\n You can manage it though!",
      "That's hard. But you can do it!",
      "That's a lot, huh? But I know we can survive this craving!"
    ].sample
  when WHAT_EMOTION_EXPERIENCING
    [
      "What feeling are you experiencing right now?",
      "How are you feeling right now?",
      "How would you describe your feeling at this moment?",
      "What emotion are you experiencing right now?"
    ].sample
  when EMOTIONS_INTENSITY
    [
      "On a scale from 1-10, how intense is that feeling?",
      "How strong is that feeling? From 1-10?",
      "Is the feeling intense or weak? From 1-10.",
      "From 1-10, how would you describe the intensity of that feeling?"
    ].sample
  when EMOTIONS_INTENSITY_REFLECTION
    [
      "Sorry you're feeling that way.\nlet's find a better way to deal with it. Ready?",
      "That's too bad. Are you ready to try to find a better way to deal with it?",
      "I'm sorry you feel that way...\nLet's look for a better way to handle it. OK?",
      "I'm sorry to hear that.\nLet's find an alternative way to handle it. Ready?"
    ].sample
  when CONNECTION_EMOTIONS_CRAVING
    if (emotions_intensity_level > 5 && craving_level > 5) ||
       (emotions_intensity_level < 5 && craving_level < 5) 
      [
        "Did you notice...\nthe connection between how badly you wanted your craving and the intensity of your emotion?",
        "It seems there is a connection between the intensity of your craving and the intensity of your emotion. Did you notice that?",
        "Hmm, looks like the intensity of the emotion you're experiencing and the the craving are related. Wouldn't you say?",
        "The level of the emotion and the level of the craving seem to be related. Did you notice that?"
      ].sample
    else
      [
        "Did you notice the gap between the intensity of your craving and your feelings?",
        "There seems to be a gap between the intensity of your craving and your feelings, right?",
        "Did you notice the difference between your craving intensity and your feelings?",
        "That's quite a difference between the intensity of your emotion and the craving, isn't it?"
      ].sample
    end
  when CONNECTION_DIDNT_NOTICE
    [
      "#{name}... I justed wanted to share that there is often a connection... don't you think?",
      "Well, I thought there is a connection. Maybe next time you will notice. :)",
      "Well #{name}, it's worth thinking about it - I think there is a connection.",
      "Just thought I'd share - often there seems like there is a connection..."
    ].sample
  when REFLECTION_AND_CHOICE
    emotion_msg = emotion ? " feeling #{emotion}," : ""    
    [
      "It's now #{user_time}, you're #{guessed_location},#{emotion_msg} and you have a craving for #{craving}. Are you going to eat it?",
      "The time is #{user_time} and you're #{emotion_msg} #{guessed_location} - feeling a craving for #{craving}. Are you going to eat it?",
      "Let's take a look at ourselves - you're #{emotion_msg} #{guessed_location}, craving #{craving}, and it's #{user_time}. Are you going to eat it...?"
    ].sample
  when GOODBYE_SUCCESS
    [
      "Great job at Pauzzing!\nYou did it! Enjoy being Pauzzitive...",
      "Good job Pauzzing!\nSuccess!\n Enjoy being 'Pauzzitive'... ;)",
      "Nice going.\nEnjoy your 'pauzzitive' state.",
      "Good! Great!\nNow you are 'pauzzitive!"
    ].sample
  when ACT_ON_CRAVING_MAYBE
    "To eat or not to eat...?\nTry to think what you would tell your best friend in this situation.\nIt is sometimes easier to give the perfect advice to a friend.\nAre you ready for your Pauzzitive alternative?"
  when ACT_ON_CRAVING_YES
    [
      "OK then... before we say goodbye,\nI'm going to ask you one last question...\nHow are you going to feel in an hour if you act on your craving?",
      "Well...\nhow are you going to feel later if you do follow your craving right now?",
      "Let me just ask you -\nHow will you feel later?\nIf you act on your craving, that is.",
      "Perhaps it's worth just thinking -\nHow are you going to feel later, if you follow your craving?"
    ].sample
  when ACT_ON_CRAVING_FEELING_BAD
    [
      'Sorry to hear that. Wanna try a Pauzzitive alternative?',
      "Oh, I'm sorry.\nHow about some Pauzzitive alternative?",
      "Eh, that's too bad. How about an alternative that's a bit more 'pauzzitive'?",
      "Mmm... sorry to hear. How about an alternative? Some a bit more pauzzitive?"
    ].sample
  when GOODBYE_FAILURE 
    [
      "Well, honesty is important.\nAnd you did a great job pauzzing back there!\nRemember, I'm always here when you want to Pauzz your craving. See you next time!",
      "Well I appreciate the honesty.\nRemember I'm here for you next time.\nGood luck!",
      "Well at least you managed to Pauzz earlier.\nRemember to chec in with me nex time you need me!\n",
      "But you did such a great job of pauzzing earlier!\nWell, perhaps next time.\nAnytime you have a craving - I'm here for you.\nSee you next time! :)"
    ].sample
  when ALTERNATIVE_ACTION_MENU
    [
      "OK, let's find an alternative. Would you like something mindful, playful, creative, or to get moving?"
    ].sample
  when MANTRA
    [
      "Please say to yourself 3 times - I am enough!\nGive me a thumbs up when you're done. :)"
    ].sample
  when MINDFUL_GOODBYE
    [
      "Pretty powerful Pauzz, right?\nStay Pauzzitive! I am here with you.\nTake Care!\nType anything to restart."
    ].sample
  when MINDFUL_STATEMENT
    [
      "Please say out loud:\n'May I be happy, May I be healthy,\nMay I be safe, May I live my life with ease.'\nTry repeating this mantra thinking about someone you care about. Give me a thumbs up to continue?"
    ].sample
  when INSPIRATIONAL_QUOTE
    [
      "Take a moment to get inspired:\n'The challenge is not to be perfect, it\'s to be whole.' - Jane Fonda.\nThat's inspiring stuff."  
    ].sample
  when BE_CREATIVE
    [
      "Write me something you're grateful for in your life.",
      "Write me something good that happened to you today.",
      "Write me one of your best qualities."
    ].sample

  when CREATIVE_GOODBYE
    [
      "You're lucky, aren't you?\nAren't you glad you Pauzzed?\nI am always here to help you Pauzz.\nSee you next time! Writ me anything next time you are craving something."
    ].sample
  when GET_MOVING1
    [
      "Let's get moving to feel great!\nCan you do some jumping jacks?"
      ].sample 
  when GET_MOVING2
    [
      "Let's get moving! Can you walk 100 steps?"
      ].sample
  when STRETCH_ARMS
    [
      "OK! Let's try something different.\nJust stretch your arms behind your back...\nL-O-N-G stretch for 5 seconds...\ngive me a thumbs up when you're done.:)"
    ].sample
  when JUMPING_JACKS
    [ "Great! Let's get to it.\nGive me 20 jumping jacks!:)\n1, 2, 3...\n...\nGive me a thumbs up when you're done. ;)"
    ].sample
  when BUTT_CLENCH
    [
      "OK then..\nJust flex those 'buns' ;)...\nFlex and relax your butt muscles 10-15 times.\nLet's count: 1, 2, 3...\n...\nGive me a thumbs up when you're done. ;)"
      ].sample
  when WALK_100_STEPS
    [
      "Let's get moving then!\nJust walk 100 steps...\nand walk that craving off!\nGive me a thumbs up when you're done. :)"
      ].sample
  when GET_MOVING_GOODBYE
    [
      "Feeling good?\nPauzzing for a few moments is always the beginning of something good.\nGlad I was hear to assist!\nBye for now!\nType anything the next time you have a craving, to summon me. :)"
    ].sample
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
  set_user_attr(:tz_offset, profile['timezone'].to_i)
  set_user_attr(:name, @text)
  goto(READY_TO_PAUZZ)
end

def ready_to_pauzz  
  if said_no
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
  set_context('craving', guessed_craving = guess_craving(@text))
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
  set_context('emotion', guessed_emotion = guess_emotion(@text))
  goto(EMOTIONS_INTENSITY) 
end

def emotions_intensity
  set_context('emotions_intensity_level',@text.to_i)
  goto(EMOTIONS_INTENSITY_REFLECTION) 
end

def emotions_intensity_reflection() goto(CONNECTION_EMOTIONS_CRAVING) end

def connection_emotions_craving() 
  if said_no
    goto(CONNECTION_DIDNT_NOTICE)
  else 
    goto(REFLECTION_AND_CHOICE)
  end
end

def connection_didnt_notice() goto(REFLECTION_AND_CHOICE) end

def reflection_and_choice
  if said_no
    goto(GOODBYE_SUCCESS)
  elsif said_maybe
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
  text = @text.downcase
  if text.include?("min")
    choice = [MANTRA,MINDFUL_STATEMENT,INSPIRATIONAL_QUOTE].sample    
  elsif text.include?('get') || text.include?('mov') 
    choice = [GET_MOVING1, GET_MOVING2].sample
  else
    choice = [BE_CREATIVE]
  end
  goto(choice) 
end

def mantra
  goto(MINDFUL_GOODBYE)
end

def mindful_goodbye
  goto(WHAT_CRAVING_NOW)
end
 
def mindful_statement
  goto(MINDFUL_GOODBYE)
end

def inspirational_quote
  goto(MINDFUL_GOODBYE)
end

def be_creative
  goto(CREATIVE_GOODBYE)
end

def creative_goodbye
  goto(WHAT_CRAVING_NOW)
end

def get_moving1
  said_no ? goto(STRETCH_ARMS) : goto(JUMPING_JACKS) 
end

def get_moving2
  said_no ? goto(BUTT_CLENCH) : goto(WALK_100_STEPS)
end

def stretch_arms()   goto(GET_MOVING_GOODBYE) end
def jumping_jacks()  goto(GET_MOVING_GOODBYE) end
def butt_clench()    goto(GET_MOVING_GOODBYE) end
def walk_100_steps() goto(GET_MOVING_GOODBYE) end

def get_moving_goodbye() goto(WHAT_CRAVING_NOW) end
# 

get '/bla' do {refresh: true} end