# Picky #

Picky is an iOS application that solves the classic problem of not being able to decide on where to eat! With a few filters of food you hate,
price, and distance, it uses Yelp's API to randomly pick you somewhere to eat.


### What is this repository for? Why can't I just download your app on the App Store? ###

* Picky is still under development, so I use bitbucket as a remote repository.
* Everything pushed to this repository should be working, so go ahead and give it a try!
* I expect to release it on the app store sometime in 2018...

### How do I get set up? ###

* On the sidebar on the left of bitbucket, there is a "Downloads" button
* Click that and then click "Download repository"
* Unzip the resulting file, and then open "Picky.xcworkspace" in Xcode
* You should be able to run it using any iPhone simulator, or your real iPhone if you have that set up.
* The app doesn't function without Location Services, so make sure you have that Allowed.


### How does picky work? ###

* I wrote a basic web server with the Vapor server-side Swift framework; the app (client) makes requests to this server, which makes requests to the yelp API, and then returns the results in JSON back to the client.
* User logins and data are handled with Firebase
* Every bit of code is written in Swift!



### Uhh, something's not working right... / How do I learn more about Picky? ###

* You can contact me at aaron_chen@berkeley.edu for more information 