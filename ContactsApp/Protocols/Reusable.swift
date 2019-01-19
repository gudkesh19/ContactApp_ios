//
//  Reusable.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 23/12/18.
//  Copyright © 2018 gudkesh. All rights reserved.
//

import UIKit

protocol Reusable {
    static func reuseIdentifier() -> String
}

extension Reusable where Self: UIView {
    
    static func reuseIdentifier() -> String {
        
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable{}
extension UICollectionViewCell: Reusable{}
