//
//  UICollectionReusableView + Extension.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 24/04/21.
//

import UIKit

extension UICollectionReusableView {
    // The @objc is added to silence the complier errors
    @objc class var identifier: String {
        return String(describing: self)
    }
}
