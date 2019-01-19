//
//  ContactListViewController.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 26/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

class ContactListViewController: UITableViewController {
    
    private var didSelect: ((Contact)->Void)?
    private var presenter: ContactPresenter?
    
    @IBOutlet private weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = self.emptyView
        tableView.registerCellFromNib(ContactTVCell.self)
        
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

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else {
            return 0
        }
        tableView.backgroundView?.isHidden = presenter.contactsCount() > 0
        return presenter.contactsCount()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContactTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        guard let contact = presenter?.getContactViewModel(at: indexPath.row) else {
            return cell
        }
        let contactName = "\(contact.firstName) \(contact.lastName ?? "")"
        cell.contactName.text = contactName
        cell.contactNumber.text = contact.contactNumber
        let imageName = "\(contact.contactNumber)_\(contact.firstName)_\(contact.lastName ?? "")"
        if let image = ImageFileManager.getImage(withName: imageName) {
            cell.contactImageView.image = image
        } else {
            DispatchQueue.global(qos: .userInitiated).async {
                let pImage = cell.contactImageView.getImageWith(contactName, color: nil, circular: true)
                ImageFileManager.save(pImage, imageName: imageName)
                DispatchQueue.main.async {
                    cell.contactImageView.image = pImage
                }
            }
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let contact = presenter?.getContact(at: indexPath.row) else {
            return
        }
        didSelect?(contact)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellHeights.contactListCellHeight.rawValue
    }

}

extension ContactListViewController {
    
    @discardableResult
    func setContact( presenter contactPresenter: ContactPresenter) -> Self {
        self.presenter = contactPresenter
        return self
    }
    
    func didSelect(contact completion: @escaping(Contact) -> Void) {
        self.didSelect = completion
    }
    
    @objc private func reloadData() {
        tableView.reloadData()
    }
    
}
