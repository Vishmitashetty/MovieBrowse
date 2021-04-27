//
//  UIImageView + Extension.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func setCornerRadius() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    //Load image from url along
    func loadImage(with urlString: String?, placeholder: UIImage? = nil) {
        let urlValue = urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString = urlValue, let url = URL(string: urlString) else { return }
        self.sd_setImage(with: url, placeholderImage: placeholder, options: []) { (image, _, cacheType, _) -> Void in
            if let downLoadedImage = image {
                if cacheType == .none {
                    self.alpha = 0
                    UIView.transition(with: self, duration: 0.4, options: .transitionCrossDissolve, animations: { () -> Void in
                        self.image = downLoadedImage
                        self.alpha = 1
                    }, completion: nil)
                }
            } else {
                self.image = placeholder
            }
        }

    }
    
    //Adding blur effect on top of image view
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}
