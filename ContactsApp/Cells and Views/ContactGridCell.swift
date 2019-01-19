//
//  ContactGridCell.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 31/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

class ContactGridCell: UICollectionViewCell {

    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contactImage.clipsToBounds = true
    }

}
