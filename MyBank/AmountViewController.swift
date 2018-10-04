//
//  AmountViewController.swift
//  MyBank
//
//  Created by Bastien DAVID on 04/10/2018.
//  Copyright © 2018 Soft Dev Gang. All rights reserved.
//

import UIKit

class AmountViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amount.delegate = self
    }
    
    @IBAction func next(_ sender: UIButton) {
        let value = amount.text!
        guard let valueAsInt = Int(value) else {
            errorMessage.text = "Amount must be a number"
            errorMessage.isHidden = false
            return
        }
        if (valueAsInt < 0) {
            errorMessage.text = "Amount must be greater than zero"
            errorMessage.isHidden = false
            return
        }
        
        if (self.getAccountType() == .CREDIT_FORBIDDEN && valueAsInt > self.getAccountBalance()) {
            errorMessage.text = "Amount cannot be greater than \(self.getAccountBalance())"
            errorMessage.isHidden = false
            return
        }
        
        if (self.getAccountType() == .CREDIT_AUTHORIZED && valueAsInt > self.getAccountBalance() + self.getAccountCreditAllowed()) {
            errorMessage.text = "Amount cannot be greater than \(self.getAccountBalance() + self.getAccountCreditAllowed())"
            errorMessage.isHidden = false
            return
        }
        
        let root = navigationController as! RootNavigationViewController
        root.amount = valueAsInt
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConfirmationViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func getAccountBalance() -> Int {
        let root = navigationController as! RootNavigationViewController
        let account = root.sourceAccount
        switch account {
        case "current account":
            return 300
        case "savings":
            return 400
        case "shared account":
            return 200
        case "stocks":
            return 300
        default:
            return 0
        }
    }
    
    func getAccountCreditAllowed() -> Int {
        let root = navigationController as! RootNavigationViewController
        let account = root.sourceAccount
        switch account {
        case "current account":
            return 50
        case "savings":
            return 0
        case "shared account":
            return 0
        case "stocks":
            return 0
        default:
            return 0
        }
    }
    
    func getAccountType() -> AccountType {
        let root = navigationController as! RootNavigationViewController
        let account = root.sourceAccount
        switch account {
        case "current account":
            return .CREDIT_AUTHORIZED
        case "savings":
            return .CREDIT_FORBIDDEN
        case "shared account":
            return .CREDIT_FORBIDDEN
        case "stocks":
            return .CREDIT_FORBIDDEN
        default:
            return .CREDIT_FORBIDDEN
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

enum AccountType {
    case CREDIT_FORBIDDEN, CREDIT_AUTHORIZED
}
