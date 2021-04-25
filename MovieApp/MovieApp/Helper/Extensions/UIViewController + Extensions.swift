//
//  UIViewController + Extensions.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 25/04/21.
//

import UIKit

extension UIViewController {
    
    func setCustomNavigation(isLeftBarButton: Bool = true) {
        guard
            let navigationBar = self.navigationController?.navigationBar  else { return }
        
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = UIColor.black
        self.navigationController?.view.backgroundColor = UIColor.clear
        // Left
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(backButtonAction))
        self.navigationItem.leftBarButtonItems = isLeftBarButton ? [backButton] : []
    }
    
    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
