//
//  Spinner.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 29/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import Foundation
import UIKit

var activeView: UIView?

extension UIViewController {
    
    func showSpinner() {
        activeView = UIView(frame: self.view.bounds)
        activeView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = activeView!.center
        activityIndicator.startAnimating()
        activeView?.addSubview(activityIndicator)
        self.view.addSubview(activeView!)
    }
    func removeSpinner(){
        activeView?.removeFromSuperview()
        activeView = nil
    }

}
