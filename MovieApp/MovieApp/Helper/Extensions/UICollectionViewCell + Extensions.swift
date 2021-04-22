//
//  UICollectionViewCell + Extensions.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//

import UIKit

extension UICollectionViewCell {
    // The @objc is added to silence the complier errors
    @objc class var identifier: String {
        return String(describing: self)
    }
}
