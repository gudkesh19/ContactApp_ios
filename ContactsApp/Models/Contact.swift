//
//  ContactModel.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 20/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

struct Contact: Decodable {
    var firstName: String
    var lastName: String?
    var contactNumber: String
    var email: String?
    var companyName: String?
}

extension Contact {
    init(with contactData: ContactData) {
        firstName = contactData.firstName ?? ""
        lastName = contactData.lastName
        contactNumber = contactData.contactNumber ?? ""
        email = contactData.email
        companyName = contactData.companyName
    }
}


struct ContactViewModel {
    var firstName: String
    var lastName: String?
    var contactNumber: String
}

extension ContactViewModel {
    init(with contact: Contact) {
        firstName = contact.firstName
        lastName = contact.lastName
        contactNumber = contact.contactNumber
    }
}
