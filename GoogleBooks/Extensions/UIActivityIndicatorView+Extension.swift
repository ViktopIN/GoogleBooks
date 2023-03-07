//
//  UIActivityIndicatorView+Extension.swift
//  GoogleBooks
//
//  Created by Виктор on 07.03.2023.
//

import UIKit

extension UIActivityIndicatorView {
    
    static func internalActivityIndicatorViewInit() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator

    }
}
