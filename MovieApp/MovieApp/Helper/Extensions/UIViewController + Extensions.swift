//
//  UIViewController + Extensions.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 25/04/21.
//

import UIKit

extension UIViewController {
    private var activityIndicatorTag: Int { return 1000009 }
    
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
    
    //Add activity indicator
    
    func startActivityIndicator(onMainThread main: Bool = true) {
        stopActivityIndicator(onMainThread: main)
        if main {
            DispatchQueue.main.async {
                self.addAcitivityIndicator()
            }
        } else {
            addAcitivityIndicator()
        }
    }
    
    private func addAcitivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.tag = self.activityIndicatorTag
        activityIndicator.center = self.view.center
        activityIndicator.color = UIColor(named: "primaryColor")
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func stopActivityIndicator(onMainThread main: Bool = true) {
        if main {
             DispatchQueue.main.async {
                self.removeAcitivityIndicator()
             }
        } else {
            removeAcitivityIndicator()
        }
    }
    
    private func removeAcitivityIndicator() {
        if let activityIndicator = self.view.subviews.filter({ $0.tag == self.activityIndicatorTag}).first as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
