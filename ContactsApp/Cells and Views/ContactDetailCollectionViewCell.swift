//
//  ContactDetailCollectionViewCell.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 20/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

class ContactDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        icon.backgroundColor = .lightGray
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.icon.layer.cornerRadius = self.icon.bounds.height / 2
        }
    }

}
