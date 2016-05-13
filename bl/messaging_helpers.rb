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