//
//  Constants.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//


import UIKit

struct Constants {
    
    struct ScreenSize {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct NotificationObserver {
        static let customerReviewLoad = "customerReviewLoad"
    }
    
    struct StoryBoardName {
        static let movieList = "MovieList"
        static let movieDetail = "MovieDetail"
    }
    
    struct StoryBoardIdentifier {
        static let movieList = "movieList"
        static let movieDetailViewController = "movieDetailViewController"
    }
}


struct AppStyleColor {
    static let themeColor = #colorLiteral(red: 0.8980392157, green: 0.2235294118, blue: 0.2078431373, alpha: 1)
}
