//
//  ContactData+CoreDataProperties.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 24/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//
//

import Foundation
import CoreData


extension ContactData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactData> {
        return NSFetchRequest<ContactData>(entityName: "ContactData")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var contactNumber: String?
    @NSManaged public var email: String?
    @NSManaged public var companyName: String?

}
