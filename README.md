# pauzzitive - 

# Links 
- flow chart:
https://dl.dropboxusercontent.com/u/10933856/Pauzz%20Messaging%20Bot%20Flow%20Chart%20%282%29.html
- screens:
https://www.justinmind.com/usernote/prototypes/12688639/20302630/20410969/index.html#/screens/d12245cc-1680-458d-89dd-4f0d7fb22724

# CSS Filewatcher:
$ filewatcher '**/*.scss' 'scss $FILENAME > $FILENAME.css; echo "created"-$FILENAME; date'

# Exclude searches:
-public/css/font*, -public/css/bootstrap_3.3.4.min.css, -public/css/lib*, -public/js/lib*, -*/node_modules/*, -*/js_dist/*, -*/.sass-cache*

# States: 

1. Intro - Welcome, what is your name?
3. Ready to Pauzz - Are you ready to Pauzz?
4. Goodbye - Goodbye!
5. Pauzz_Yawn - Pauzz by Yawn 
6. High_five - High five
7. Location - Where are you?
8. What_craving_now - What are you craving this time?
9. How_bad - How bad do you want it?
10. Want_it_low - I want it low
11. Want_it_high - I want it high
12. What_emotion_experiencing - What emotion are you experiencing?
13. Emotions_Intensity - how intense is the emotion?
14. Emotions_Intensity_reflection - sorry you're feeling that way, let's find a better way to deal with it. Ready?
15. Connection_Emotions_Craving - did you notice the connection between the how badly you want <craving> and intensity of <emotion>?
16. Connection_Noticed - I just wanted to share that there is usually a connection... don't you think?
17. Connection_Didnt_notice - it's now <time>, you're at <location>, experiencing <emotion>, and you have a craving for <craving>. Are you going to eat it?
