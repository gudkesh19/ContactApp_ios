//
//  ContactTVCell.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 20/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

class ContactTVCell: UITableViewCell {

    @IBOutlet  weak var contactNumber: UILabel!
    @IBOutlet  weak var contactName: UILabel!
    @IBOutlet  weak var contactImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contactImageView.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contactImageView.image = nil
        contactName.text = ""
        contactNumber.text = ""
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
