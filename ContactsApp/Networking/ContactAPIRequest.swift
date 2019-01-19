//
//  ContactAPIRequest.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 24/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable
    var resourceURLString: String {get}
}


struct ContactRequest: APIRequest  {
    typealias Response = [Contact]
    
    var resourceURLString: String {
        return contactMockAPIString
    }
}
