//
//  ViewController.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 20/04/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(Environment.serverEndPoint)
        print(Environment.apiKey)
        print(Environment.apiVersion)
        print(MovieApiRoute.reviews(movieId: "1222", pageNo: 1).url)
    }


}

