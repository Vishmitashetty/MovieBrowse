# MovieBrowse

Movie Browse App using open source api themoviedb.org

## Architecture

This App is based upon Apple standard MVC Architecture, And code is arranged in following format:

1. HTTP Task: Common network layer to manage http call.
2. Route File: Common place to manage url route for all api's throught project.
3. Repository: Using this appraoch we can seemlessly integrate Dependency Injection for Unit test cases.
4. XcConfig: To manage configuration accross various environment ie: Dev, SIT, UAT etc.
5. CoreDataStack: Defined managedObject, persistence container and other core data configuration.
6. Logging: Implemented os logs in network and offline db layer.


## Modules

For each feature we maintained different module and used storyboard and xib's to create UI.

1. Home: This module includes movie list.
3. Details: This module includes synoypsis, similar movie, customer review, cast and crew details.
4. Customer Reviews: This module includes customer review screen.
5. Movie Search: This module includes movie search and also support offline recent search.
6. Helper: This module includes Constants, UIKit and Foundation Kit extensions.
7. Search Algorithm: Implemented wrapper logic for search algorithm based on Boyer moore string matching algorithm to get relevant search result.

## Unit test coverage (~ 60%)

Modules covered under unit test cases:
1. Home
2. Detail
3. Customer Review
4. Movie Search
5. Environment

## Third party integration

This project is using cocoapods as package dependecy manager.
1. Lottie
2. SDWebImage

# Project Demo

https://user-images.githubusercontent.com/8758234/116030686-c4ec3480-a679-11eb-9a3b-cfbdae581636.mov





