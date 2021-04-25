# MovieBrowse

Designed Movie Browse App using open source api themoviedb.org

## Architecture
This App is based upon Apple standard MVC Architecture, And code is arranged in following format:

1. HTTP Task: Common network layer to manage http call
2. Route File: Common place to manage url route for all api's throught project.
3. Repository: Using this we can easily maintain DI for Unit test cases
4. XcConfig: To manage configuration accross various environment ie: Dev, SIT, UAT etc.
5. CoreDataStack: Defined managedObject, persistence container and other core data configuration.


## Modules

For each feature we maintained different module and used storyboard and xib's to create UI

1. Home -> This module includes movie list
3. Details -> This module includes synoypsis, similar movie, customer review, cast and crew details
4. Customer Reviews -> This module includes customer review screen
5. Movie Search -> This module includes movie search and also support offline recent search
6. Helper: This module includes Constants, UIKit and Foundation Kit extension

## Unit test coverage (~ 48%)

Modules covered under unit test cases:
1. Home
2. Detail
3. Customer Review

## Third party integration

This project is using cocoapods as dependecy manager
1. Lottie
2. SDWebImage

# Project Demo


Uploading Screen Recording 2021-04-25 at 10.40.19 PM.mov…

