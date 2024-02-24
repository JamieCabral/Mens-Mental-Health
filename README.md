This is my submission to the Apple Swift Student Challenge.

I chose Men's Mental Health due to the stigma around it and how hard it can be for males to reach out and get the help that they need. I have first and second hand experience of this
and so I wanted to create an app that could have a real societal impact. 

This project was created in Xcode using the Swift programming language. The task was to create an app that can be used, in its entirety, within 3 minutes. As this app has a journal aspect 
to it, I have used CoreData to ensure that entries persist between app launches.This app is easy to use with only 2 different functions: a journal and a grid of emotions that can be selected
to receive advice and, in all cases bar 'happy', links to other resources that allow users to reach out to a real person. The central of the three pages stores the strings entered in the 
journal page with the date attached so that users can see and/or delete their entries.

<img width="342" alt="Screenshot 2024-02-24 at 16 15 05" src="https://github.com/JamieCabral/Mens-Mental-Health/assets/161150774/0aae44f7-253c-4b3d-bfab-20985bf20f41">
<img width="341" alt="Screenshot 2024-02-24 at 16 15 34" src="https://github.com/JamieCabral/Mens-Mental-Health/assets/161150774/2a7d231c-9149-446c-aa08-5c9ffeda0ff1">
<img width="341" alt="Screenshot 2024-02-24 at 16 15 57" src="https://github.com/JamieCabral/Mens-Mental-Health/assets/161150774/79797b38-20b2-4eae-9180-c67c0f224c2b">

Within the entries, there is a sentiment score which uses Natural Language Processing (NLP) to give a score between -1 and 1 with -1 being as negative as positive and 1 being the same but
for positive. This is done by importing NaturalLanguage, an Apple-supplied machine learning framework.

For installation:

Please download all files into the same folder and open in Xcode. This project uses features only available in iOS 17 and so Xcode must be updated to Xcode 15 or later.
