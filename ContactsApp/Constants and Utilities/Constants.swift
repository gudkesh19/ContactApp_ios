//
//  Constants.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 20/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation
import UIKit

enum ContactError: Error {
    case server(message: String)
    case parsingError
    case invalidURL
    case networkError
}

enum CellHeights: CGFloat {
    case contactListCellHeight = 74
    case contactDetailsCellHeight = 60
    case contactGridCellHeight = 150
}

let cellPadding: CGFloat = 8
let contactMockAPIString = "https://www.mocky.io/v2/5c24812e30000051007a5ff3"
