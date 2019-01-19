//
//  ContactAPIResponse.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 24/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

enum Result<value: Decodable> {
    case success(value)
    case failure(Error)
}

typealias ResponseCallback<value: Decodable> = (Result<value>) -> Void


 
