//
//  ViewController+Helper.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 31/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func add(asChildViewController viewController: UIViewController) {
        
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParent: self)
    }
    
    func remove(asChildViewController viewController: UIViewController) {
        
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
        
    }
}
