//
//  HomeViewController.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 31/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    private enum ContactStyle {
        case list
        case grid
    }

    private var contactStyle: ContactStyle = .list
    
    var addContact: (()->Void)?
    var didSelect: ((Contact)->Void)?
    
    @IBOutlet private weak var toggleButton: UIBarButtonItem!
    
    private let presenter = ContactPresenter()
    
    private lazy var loader: LoadingViewController = {
        let loader: LoadingViewController = UIStoryboard(storyBoard: .loader).instantiateViewController()
        return loader
    }()
    
    private lazy var contactListVC: ContactListViewController = {
        let vc: ContactListViewController = UIStoryboard(storyBoard: .main).instantiateViewController()
        vc.setContact(presenter: presenter)
        vc.didSelect {[weak self] (contact) in
            self?.didSelect?(contact)
        }
        return vc
    }()
    
    private lazy var contactGridVC: ContactGridViewController = {
        let vc: ContactGridViewController = UIStoryboard(storyBoard: .main).instantiateViewController()
        vc.setContact(presenter: presenter)
        vc.didSelect {[weak self] (contact) in
            self?.didSelect?(contact)
        }
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        self.navigationItem.title = "Contacts"
        self.navigationController?.navigationBar.prefersLargeTitles = true;
        NotificationCenter.default.addObserver(self, selector: #selector(contactUpdated(_:)), name: .contactsUpdateNotification, object: nil)
        add(asChildViewController: contactListVC)
        presenter.fetchContactList()
    }
    
    @IBAction func importContact(_ sender: Any) {
        presenter.importContacts {[weak self] (success, message) in
            guard success else {
                return
            }
            self?.presenter.fetchContactList()
        }
    }
    
    @IBAction func addNewContact(_ sender: Any) {
        addContact?()
    }
    
    @IBAction func toggleContactViewStyle(_ sender: UIBarButtonItem) {
        if contactStyle == .list {
            remove(asChildViewController: contactListVC)
            add(asChildViewController: contactGridVC)
        } else {
            remove(asChildViewController: contactGridVC)
            add(asChildViewController: contactListVC)
        }
        toggleButton.title = contactStyle == .list ? "ListView" : "GridView"
        contactStyle = contactStyle == .list ? .grid : .list

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .contactsUpdateNotification, object: nil)
        presenter.removeDelegate()
    }

}

extension HomeViewController: ContactViewDelegate {
    
    
    func startLoading() {
        add(asChildViewController: loader)
    }
    
    func stopLoading() {
        remove(asChildViewController: loader)
    }
    
}

extension HomeViewController {
    
    @objc private func contactUpdated(_ notification: Notification) {
        presenter.fetchContactList()
    }
}
