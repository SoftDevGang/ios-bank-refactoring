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
    
    var transactionBuilder: TransactionBuilder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amount.delegate = self
    }
    
    @IBAction func next(_ sender: UIButton) {
        
        // is the actual messages ui or business
        
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
        
        transactionBuilder.amount = valueAsInt
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConfirmationViewController") as! ConfirmationViewController
        viewController.transactionBuilder = transactionBuilder
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func getAccountBalance() -> Int {
        // this logic belongs to the model, should be injected
        let account = transactionBuilder.sourceAccount
        return AccountWebService().getBalance(account!)
    }
    
    func getAccountCreditAllowed() -> Int {
        // this logic belongs to the model, should be injected
        let account = transactionBuilder.sourceAccount
        return AccountWebService().getAccountCreditAllowed(account!)
    }
    
    func getAccountType() -> AccountType {
        // this logic belongs to the model, should be injected
        let account = transactionBuilder.sourceAccount
        return AccountWebService().getAccountType(account!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
