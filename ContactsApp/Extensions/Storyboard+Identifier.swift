//
//  Storyboard+Identifier.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar  on 20/12/18.
//  Copyright © 2018 gudkesh. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    enum Storyboard: String {
        case main
        case details
        case newContact
        case loader
        
        
       fileprivate var name: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(storyBoard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyBoard.name, bundle: bundle)
    }
    
    class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.name, bundle: bundle)
    }
}

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>() -> T  {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        return viewController
    }
}
