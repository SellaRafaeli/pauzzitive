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

get '/messaging_helpers_refresh' do true end