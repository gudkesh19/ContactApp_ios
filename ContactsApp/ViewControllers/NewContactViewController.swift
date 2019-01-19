//
//  ViewController.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 20/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

class NewContactViewController: UIViewController {

    @IBOutlet private weak var company: UITextField!
    @IBOutlet private weak var email: UITextField!
    @IBOutlet private weak var contactNumber: UITextField!
    @IBOutlet private weak var lastName: UITextField!
    @IBOutlet private weak var firstName: UITextField!
    
    @IBOutlet weak var error: UILabel!
    @IBOutlet private weak var save: UIButton!
    
    @IBOutlet var textFields: [UITextField]!
    
    private let contactManager = ContactsManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        error.isHidden = true
        save.isEnabled = false
        self.navigationItem.title = "Create Contact"
        firstName.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)
        
    }

    @IBAction private func saveButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        let contact = Contact(firstName: firstName.text!,
                                   lastName: lastName.text,
                                   contactNumber: contactNumber.text!,
                                   email: email.text,
                                   companyName: company.text)
        
        contactManager.save(contact: contact) {[weak self] (success, message) in
            if success {
                self?.clearTextFields()
                CAToast.show(withMessage: message)
                NotificationCenter.default.post(name: .contactsUpdateNotification, object: nil)
                self?.navigationController?.popViewController(animated: true)
                
            } else {
                CAToast.show(withMessage: message)
            }
        }
    }
    
    private func clearTextFields() {
        save.isEnabled = false
        for tf in textFields {
            tf.text = nil
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
    }
}

extension NewContactViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstName:
            let (valid, message) = validate(textField)
            
            if valid {
                lastName.becomeFirstResponder()
            }
            updateError(message, isHidden: valid)
        case lastName:
            contactNumber.becomeFirstResponder()
        case contactNumber:
            let (valid, message) = validate(textField)
            
            if valid {
                email.becomeFirstResponder()
            }
           updateError(message, isHidden: valid)
            
        case email:
            company.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
            let res = validateAllfields()
            updateError(res.1, isHidden: res.0)
            if save.isEnabled {
                saveButtonTapped(save)
            }
            
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       let result = validate(textField)
        updateError(result.1, isHidden: result.0)
    }
    
    
    private func validate(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            return (false, nil)
        }
        
        if textField == firstName {
            return (text.count > 3, "Your first name cannot be empty.")
        }
        else if textField == contactNumber {
            return (text.count > 8, "Your contact number cannot be empty.")
        }
        
        return (true, nil)
    }
    
    private func updateError(_ message: String?, isHidden: Bool) {
        self.error.text = message
        UIView.animate(withDuration: 0.25, animations: {
            self.error.isHidden = isHidden
        })
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        let res = validateAllfields()
        save.isEnabled = res.0
    }
    
    @discardableResult
    private func validateAllfields() -> (Bool,String? ){
        var formIsValid = true
        var message: String? = nil
        for textField in textFields {
            // Validate Text Field
            let (valid, errmessage) = validate(textField)
            guard valid else {
                formIsValid = false
                message = errmessage
                break
            }
        }
        return (formIsValid, message)
    }
}

