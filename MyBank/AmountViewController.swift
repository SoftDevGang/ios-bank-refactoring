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
        return AccountWebService().getBalance(account!)
    }
    
    func getAccountCreditAllowed() -> Int {
        let root = navigationController as! RootNavigationViewController
        let account = root.sourceAccount
        return AccountWebService().getAccountCreditAllowed(account!)
    }
    
    func getAccountType() -> AccountType {
        let root = navigationController as! RootNavigationViewController
        let account = root.sourceAccount
        return AccountWebService().getAccountType(account!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
