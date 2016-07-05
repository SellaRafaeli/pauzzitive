def print_msg
  puts Time.now.to_s
  puts "received params: ".blue
  puts JSON.pretty_generate(params).light_blue
  puts "---"  
end

def kinky_text
  verb = Faker::Hacker.verb
  noun = Faker::Hacker.noun
  "I'd like to #{verb} your #{noun}..."
end

def guess_location(text) # work, home, restaurant, social event, out & about
  text = text.downcase
  
  return :'at work' if text.include_any?('work','job','office','business')
  
  return :'at home' if text.include_any?('home','house','place','apartment','bed','room','table')
  
  return :'at a restaurant' if text.include_any?('restaurant','house','place','apartment','bed','room','table')

  return :'at a social event' if text.include_any?('party','meet','event','wedding','together','friend','dinner')

  return :'out and about' if text.include_any?('out', 'travel', 'way', 'driving')

  #default
  return :'out'
end

def guess_craving(text)
  text = text.downcase

  return :cookies if text.include_any?('cookies', 'chocolate chip cookies', 'granola cookies', 'oatmeal cookies', 'oatmeal raisin cookies', 'chocolate chocolate chip cookies', 'orio')

  return :candy if text.include_any?('julyfruits', 'Candy Buttons', 'candy', 'blow pop', 'candy corn', 'gum', 'charms', 'gummi bears', 'dots', 'jawbreaker', 'Gushers', 'jelly bell', 'jelly bean', 'jujubes', 'junior mints', 'laffy taffy', 'lifesavers', 'Mike and Ike', 'Milk duds', 'Nerd', 'pez', 'razzles', 'skittles', 'runts', 'smarties', 'sour patc', 'starburst', 'tootsie po', 'tootsie roll', 'Swedish fish', 'twizzlers', 'york', 'whoppers')

  return :chocolate if text.include_any?('choco','chocolate', 'Reese’s', 'M&M', 'Hershey kisses', 'Mars bar', 'three musketeers', 'Aero', 'Almond joy', 'Baby Rut', 'Bar one', 'Big turk', 'Bounty', 'Butterfinger', 'milk chocolate', 'dark chocolate', 'crunch', 'dove bar', 'fudge', 'heath bar', 'kinder', 'kinder bueno', 'Mars bar', 'Milky way', 'mounds', 'Smores', 'snickers', 'take 5', 'kit kat', 'twix')

  return :snack if text.include_any?('Pretzels', 'bagel', 'Auntie Anne', 'bun', 'biscuit', 'bread roll', 'bread')

  return :cupcakes if text.include_any?('cupcake')

  return :muffins if text.include_any?('muffin')

  return :chips if text.include_any?('chips','dorito','cheeto','cheese puffs')

  return :pie if text.include_any?('pie','flam')

  return :cake if text.include_any?('cake','blondie','souffle','tiramisu')

  return :pudding if text.include_any?('custard','pudding','jello')

  return :hamburger if text.include_any?('burger','slider','sloppy joe','steak burger','cheese steak')

  return :hotdog if text.include_any?('dog','sausage','frankfurter')

  return :pancake if text.include_any?('pancake','crepe','waffle','french toast')

  return :sugardrink if text.include_any?('soda','coke','sprite','pepsi','mountain dew','fanta','pepper','redbull','monster')

  return :cereal if text.include_any?('cereal','apple jacks','coco','cheerios','crunch','cookie crisp','crispix','flakes','chex')

  return :chicken if text.include_any?('chicken')

  return :milkshake if text.include_any?('shake')

  return :pasta if text.include_any?('mac','spaghetti','pasta')

  return :pizza if text.include_any?('pizza')

  return :donuts if text.include_any?('donut','cinammon roll')

  return :craving
  #NO category: Word 1 Nachos, Word 1 Chili, Word1 Burrito Word 1 Churros, Word 1 Pop Tarts, Word 1 Sugar, Word 1 Tacos Word 1 Marshmallows, Word 1 Cheese sticks Word 1 Popcorn Word 1 Onion rings
end

def guess_emotion(text)
  text = text.downcase
  return :sad if text.include_any?('sad','bitter', 'unhappy', 'depress', 'dismal', 'heartbroken', 'melancholy', 'mournful', 'pessimistic', 'somber', 'sorrowful', 'sorry', 'wistful', 'bereav', 'blue', 'cheerless', 'deject', 'despairing', 'despondent', 'disconsolate', 'distress', 'doleful', 'down', 'down in dumps', 'down in mouth', 'downcast', 'forlorn', 'gloomy', 'glum', 'grief-stricken', 'griev', 'heartsick', 'heavyheart', 'hurting', 'in doldrums', 'in grief', 'in the dumps', 'languishing', 'low', 'low-spirit', 'lugubrious', 'morbid', 'morose', 'out of sorts', 'pensive', 'sick at heart', 'troubl', 'weeping')

  return :frustrated if text.include_any?('frus', 'balk', 'crabb', 'cramp', 'crimp', 'defeat', 'discontent', 'discourag', 'dishearten', 'embitter', 'foil', 'irk', 'stonewall', 'stymi', 'foul up', 'hung up on', 'resentful', 'through the mill', 'ungratifi', 'unsat', 'unslak')

  return :bored if text.include_any?('bore', 'off', 'disinterest', 'fatig', 'tir', 'dull', 'blas', 'inattentive', 'spiritless')

  return :scared if text.include_any?('scar', 'terror', 'strick', 'afraid', 'anxious', 'fearful', 'panic', 'petrif', 'shaken', 'terrif', 'aghast', 'cold feet', 'panic')

  return :angry if text.include_any?('ang', 'anger', 'angr', 'vex', 'annoy', 'bitter', 'enrag', 'exasperat', 'furious', 'heat', 'impassion', 'indignant', 'irate', 'irritable', 'irritat', 'offend', 'outrag', 'resentful', 'sullen', 'uptight', 'affront', 'antagoniz', 'chaf', 'choleric', 'convuls', 'cross', 'displeas', 'exacerbat', 'ferocious', 'fierce', 'fiery', 'fuming', 'gall', 'hateful', 'hot', 'huffy', 'ill-temper', 'incens', 'inflam', 'infuriat', 'irascible', 'ireful', 'madden', 'nettl', 'piqu', 'provok', 'raging', 'ril', 'sore', 'splenetic', 'storming', 'sulky', 'tumul', 'turbulent')

  return :lonely if text.include_any?('lone', 'alon', 'unsocial', 'desert', 'desolate', 'destitute', 'empty', 'homeless', 'isolated', 'lonesome', 'reclusive', 'solitary', 'abandon', 'alone', 'apart', 'by oneself', 'comfortless', 'companionless', 'disconsolate', 'down', 'estrang', 'forsaken', 'godforsaken', 'left', 'lone', 'outcast', 'reject', 'renounc', 'seclud', 'single', 'troglodytic', 'unattend', 'unbefriend', 'uncherish')

  return :tired if text.include_any?("tir", "worn out", "drain", "exasperat", "fatigu", "irritat", "overwork", "sleepy", "stale", "beat", "collapsing", "consum", "drooping", "empty", "enervat", "fagg", "faint", "finish", "flagging", "irk", "jad", "overtax", "prostrat", "spent", "wast", "worn", "all in", "asleep", "broken-down", "burn out", "dead on one's feet", "dog-tir", "done", "done", "droopy", "drowsy", "fed up", "haggard", "narcoleptic", "petered out", "played out", "pooped", "run-down", "sick of")
end

def said_no
  @text.downcase.include_any?('no')
end

def said_maybe
  @text.downcase.include_any?('maybe','perhaps','guess')
end

get '/messaging_helpers_refresh' do true end