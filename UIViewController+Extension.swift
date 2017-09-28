//
//  UIViewController+Extension.swift
//  Lanex
//
//  Created by Bryan Rivera on 27/09/2017.
//  Copyright © 2017 Bryan Rivera. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func loadViewControllerWithStoryboardID(_ storyboardID: String, fromStoryBoard storyboardName:String) -> UIViewController {
        let storyboard : UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: storyboardID)
        
        return controller
    }
}
