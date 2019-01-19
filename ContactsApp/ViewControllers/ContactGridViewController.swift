//
//  ContactGridViewController.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 28/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit


class ContactGridViewController: UIViewController {
    private let columns = 2
    private var didSelect: ((Contact)->Void)?
    private var presenter: ContactPresenter?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet private weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundView = emptyView
        // Register cell classes
        self.collectionView!.registerCellFromNib(ContactGridCell.self)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .contactFetchedNotification, object: nil)
        reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .contactFetchedNotification, object: nil)
    }

}

extension ContactGridViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDataSource
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else {
            return 0
        }
        collectionView.backgroundView?.isHidden = presenter.contactsCount() > 0
        return presenter.contactsCount()
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ContactGridCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        
        guard let contact = presenter?.getContactViewModel(at: indexPath.row) else {
            return cell
        }
        let contactName = "\(contact.firstName) \(contact.lastName ?? "")"
        cell.contactName.text = contactName
        cell.contactNumber.text = contact.contactNumber
        let imageName = "\(contact.contactNumber)_\(contact.firstName)_\(contact.lastName ?? "")"
        if let image = ImageFileManager.getImage(withName: imageName) {
            cell.contactImage.image = image
        } else {
            DispatchQueue.global(qos: .userInitiated).async {
                let pImage = cell.contactImage.getImageWith(contactName, color: nil, circular: true)
                ImageFileManager.save(pImage, imageName: imageName)
                DispatchQueue.main.async {
                    cell.contactImage.image = pImage
                }
            }
        }
        
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let contact = presenter?.getContact(at: indexPath.row) else {
            return
        }
        didSelect?(contact)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - ((CGFloat(columns) + 1) * 8)) / CGFloat(columns)
        let height = CellHeights.contactGridCellHeight.rawValue
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellPadding
    }

}

extension ContactGridViewController {
    
    @discardableResult
    func setContact( presenter contactPresenter: ContactPresenter) -> Self {
        self.presenter = contactPresenter
        return self
    }
    
    func didSelect(contact completion: @escaping(Contact) -> Void) {
        self.didSelect = completion
    }
    
   @objc private func reloadData() {
        collectionView.reloadData()
    }
    
}
