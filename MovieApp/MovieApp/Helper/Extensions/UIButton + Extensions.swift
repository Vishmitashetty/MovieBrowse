//
//  UIButton + Extensions.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 25/04/21.
//

import UIKit

extension UIButton {
    func setButton() {
        self.tintColor = AppStyleColor.themeColor
        self.layer.borderWidth = 1.0
        self.layer.borderColor = AppStyleColor.themeColor.cgColor
        self.layer.cornerRadius = self.layer.frame.height/2
    }
}
