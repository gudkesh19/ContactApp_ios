//
//  ContactListPresenter.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 24/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

 protocol ContactViewDelegate: class {
    func stopLoading()
    func startLoading()
}

 class ContactPresenter: NSObject {
    weak var delegate: ContactViewDelegate?
    private let contactManager = ContactsManager.sharedInstance

    private var contactList = [Contact]()
    private var contactViewData = [ContactViewModel]() {
        didSet {
            NotificationCenter.default.post(name: .contactFetchedNotification, object: nil)
        }
    }

//    override init() {
//        super.init()
//        fetchContactList()
//    }
    
      func fetchContactList() {
        delegate?.startLoading()
        DispatchQueue.main.async {[weak self] in
            guard let data = self?.contactManager.fetchContactList() else {
                return
            }
            self?.contactList = data
            self?.contactViewData = data.compactMap({ContactViewModel(with: $0)})
            self?.delegate?.stopLoading()
        }
        
    }
    
    func importContacts(_ completion: @escaping(Bool, String)->Void) {
        delegate?.startLoading()
        contactManager.importContacts {[weak self] (success, messsage)  in
            completion(success, messsage)
            self?.delegate?.stopLoading()
        }
    }
    
    func getContact(at index: Int) -> Contact? {
        guard index < contactList.count else {
            return nil
        }
        return contactList[index]
    }
    
    func getContactViewModel(at index: Int) -> ContactViewModel? {
        guard index < contactViewData.count else {
            return nil
        }
        return contactViewData[index]
    }
    
    func contactsCount() -> Int {
        return contactViewData.count
    }
    
    func attachView(delegate: ContactViewDelegate) {
        self.delegate = delegate
    }
    
    func removeDelegate() {
        self.delegate = nil
    }
    
}
