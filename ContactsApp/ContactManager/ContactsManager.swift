//
//  ContactsManager.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 20/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation
import CoreData

class ContactsManager {
    
    private let persistencyManager = CoreDataManager(with: "ContactModel")
    private let httpClient = ContactsAPIClient(with: URLSession(configuration: .default))
    
    static let sharedInstance = ContactsManager()
    private init(){}
    
    func delete(contact: Contact, completion: @escaping(Bool, String) -> Void) {
       
        persistencyManager.performBackgroundTask { (context) in
            
            let request = NSFetchRequest<ContactData>(entityName: "ContactData")
            let predicate = NSPredicate(format: "contactNumber == %@", contact.contactNumber)
            request.predicate = predicate
            
            let res = try! context.fetch(request)
            if let contactTodelete = res.last {
                context.delete(contactTodelete)
            }
            if context.hasChanges {
                do {
                    try context.save()
                    print("Deleted successfully")
                    DispatchQueue.main.async {
                        completion(true, "Contact deleted successfully.")
                    }
                } catch {
                    print("Failure to save context: \(error)")
                    DispatchQueue.main.async {
                        completion(false, "Failed to delete contact.")
                    }
                }
            }

            
        }
    }
    
    func save(contact: Contact, completion: @escaping(Bool, String) -> Void) {
        persistencyManager.performBackgroundTask { (context) in
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            let cnt = ContactData(context: context)
            cnt.firstName = contact.firstName
            cnt.lastName = contact.lastName
            cnt.contactNumber = contact.contactNumber
            cnt.email = contact.email
            cnt.companyName = contact.companyName
            if context.hasChanges {
                do {
                    try context.save()
                    print("Saved successfully")
                    DispatchQueue.main.async {
                        completion(true, "Contact saved successfully.")
                    }
                } catch {
                    print("Failure to save context: \(error)")
                    DispatchQueue.main.async {
                        completion(false, "Failed to save contact.")
                    }
                }
            }
        }
    }
    
    private func save(contacts: [Contact], completion: @escaping(Bool, String) -> Void) {
        persistencyManager.performBackgroundTask { (context) in
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            for contact in contacts {
                let cnt = ContactData(context: context)
                cnt.firstName = contact.firstName
                cnt.lastName = contact.lastName
                cnt.contactNumber = contact.contactNumber
                cnt.email = contact.email
                cnt.companyName = contact.companyName
            }
            if context.hasChanges {
                do {
                    try context.save()
                    print("imported contacts saved successfully")
                    DispatchQueue.main.async {
                        completion(true, "Contact saved successfully.")
                    }
                } catch {
                    print("Failure to save context: \(error)")
                    DispatchQueue.main.async {
                        completion(false, "Failed to save imported contact.")
                    }
                }
            }
        }
    }
    
    private func doesContactExists(contact: Contact) -> Bool {
        var exists = false
        persistencyManager.performViewTask { (context) in
            let request = NSFetchRequest<ContactData>(entityName: "ContactData")
            let predicate = NSPredicate(format: "contactNumber == %@", contact.contactNumber)
            request.predicate = predicate
            
            let res = try! context.fetch(request)
            exists = res.count > 0
        }
        return exists
    }
    
    func fetchContactList()-> [Contact] {
        
        var contacts = [Contact]()
        persistencyManager.performViewTask { (context) in
            let request = NSFetchRequest<ContactData>(entityName: "ContactData")
            let firstsort = NSSortDescriptor(key: "firstName", ascending: true)
            let lastsort = NSSortDescriptor(key: "lastName", ascending: true)
            request.sortDescriptors = [firstsort, lastsort]
            do {
                let res = try context.fetch(request)
                contacts = res.compactMap{Contact(with: $0)}
                
            } catch {
                print("Failed to load the contacts: \(error)")
            }
            
        }
        return contacts
    }
    
    func importContacts(_ completion: @escaping(Bool,String)->Void) {
        httpClient.fetch(ContactRequest()) { (response) in
            switch response {
            case .success(let contacts):
                self.save(contacts: contacts, completion: { (success, message) in
                    DispatchQueue.main.async {
                        completion(success, message)
                    }
                })
                
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(false, "import failed")
                }
            }
        }
    }
}
