//
//  AppFlow.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 24/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

class AppFlow: NSObject {
    private var window: UIWindow
    private var rootNavigationVC: UINavigationController?
    
    init(with window: UIWindow) {
        self.window = window
        super.init()
        configRootVC()
    }
}

extension AppFlow {
    private func configRootVC() {
        guard let navVC = window.rootViewController as? UINavigationController, let vc = navVC.viewControllers[0] as? HomeViewController else {
            return
        }
        rootNavigationVC = navVC
        vc.addContact = {[weak self] in
            self?.pushNewContactVC()
        }
        vc.didSelect = { [weak self] (contact) in
            self?.showContactDetails(for: contact)
        }
    }
    
    private func pushNewContactVC() {
        let vc: NewContactViewController = UIStoryboard.storyboard(storyboard: .newContact).instantiateViewController()
        rootNavigationVC?.pushViewController(vc, animated: true)
    }
    
    private func showContactDetails( for contact: Contact) {
        let vc: ContactDetailsViewController = UIStoryboard.storyboard(storyboard: .details).instantiateViewController()
        vc.contact = contact
        rootNavigationVC?.pushViewController(vc, animated: true)
    }
}
