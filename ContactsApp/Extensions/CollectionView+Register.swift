//
//  CollectionView+Register.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 20/12/18
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerCellFromClass<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier())
    }
    
    func registerCellFromNib<T: UICollectionViewCell>(_: T.Type) {
//        let bundle = Bundle(for: T.self)
        let name = NSStringFromClass(T.self).components(separatedBy: ".").last!
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier())
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier(), for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier())")
        }
        
        return cell
    }
}


extension UITableView {
    
    func registerCellFromClass<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier())
    }
    
    func registerCellFromNib<T: UITableViewCell>(_: T.Type) {
        //        let bundle = Bundle(for: T.self)
        let name = NSStringFromClass(T.self).components(separatedBy: ".").last!
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier())
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier(), for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier())")
        }
        
        return cell
    }
}
