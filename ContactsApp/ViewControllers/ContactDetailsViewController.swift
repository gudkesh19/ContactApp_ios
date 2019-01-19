//
//  ContactDetailsViewController.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 24/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var email: UILabel!
    @IBOutlet private weak var companyName: UILabel!
    @IBOutlet private weak var contactNumber: UILabel!
    @IBOutlet private weak var contactName: UILabel!
    @IBOutlet private weak var contactImage: UIImageView!
    
    var contact: Contact?
    
    private let collectionViewDataSource = ["message", "call", "video", "mail", "pay"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Contact Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteContact))
        collectionView.registerCellFromNib(ContactDetailCollectionViewCell.self)
        updateView()
    }
    
    private func updateView() {
        contactImage.backgroundColor = .clear
        guard let contact = contact else {
            return
        }
        let name = "\(contact.firstName) \(contact.lastName ?? "")"
        contactName.text = name
        contactNumber.text = contact.contactNumber
        email.text = contact.email
        companyName.text = contact.companyName
        let imageName = "\(contact.contactNumber)_\(contact.firstName)_\(contact.lastName ?? "")"
        if let image = ImageFileManager.getImage(withName: imageName) {
            contactImage.image = image
        } else {
            DispatchQueue.global(qos: .userInitiated).async {[weak self] in
                let pImage = self?.contactImage!.getImageWith(name, color: nil, circular: true)
                ImageFileManager.save(pImage!, imageName: imageName)
                DispatchQueue.main.async {
                    self?.contactImage.image = pImage
                }
            }
        }
    }
    
    @objc private func deleteContact() {
        guard let contact = self.contact else {
            return
        }
        ContactsManager.sharedInstance.delete(contact: contact) {[weak self] (success, message) in
            CAToast.show(withMessage: message)
            if success {
                let imageName = "\(contact.contactNumber)_\(contact.firstName)_\(contact.lastName ?? "")"
                ImageFileManager.deleteImage(withName: imageName)
                NotificationCenter.default.post(name: .contactsUpdateNotification, object: nil)
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }

}

extension ContactDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ContactDetailCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.title.text = collectionViewDataSource[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(collectionViewDataSource.count)
        let width = (UIScreen.main.bounds.width - ((count + 1) * 8)) / count
        let height = CellHeights.contactDetailsCellHeight.rawValue
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellPadding
    }
    
    
}
