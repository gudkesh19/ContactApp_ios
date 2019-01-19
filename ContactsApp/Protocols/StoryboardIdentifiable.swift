//
//  StoryboardIdentifiable.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 23/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String {get}
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable{}
