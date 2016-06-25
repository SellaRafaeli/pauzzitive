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

  return :donuts if text.inlude_any?('donut','cinammon roll')

  return :craving
  #NO category: Word 1 Nachos, Word 1 Chili, Word1 Burrito Word 1 Churros, Word 1 Pop Tarts, Word 1 Sugar, Word 1 Tacos Word 1 Marshmallows, Word 1 Cheese sticks Word 1 Popcorn Word 1 Onion rings
end

def said_no
  @text.downcase.inlude_any?('no')
end

def said_maybe
  @text.downcase.inlude_any?('maybe','perhaps','guess')
end

get '/messaging_helpers_refresh' do true end