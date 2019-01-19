//
//  LoadingViewController.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 31/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet private weak var loader: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loader.startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loader.stopAnimating()
    }
    

}
