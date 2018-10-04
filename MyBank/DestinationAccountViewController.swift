//
//  DestinationAccountViewController.swift
//  MyBank
//
//  Created by Bastien DAVID on 04/10/2018.
//  Copyright © 2018 Soft Dev Gang. All rights reserved.
//

import UIKit

class DestinationAccountViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var transactionBuilder: TransactionBuilder!
    
    @IBOutlet weak var destinationAccount: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        destinationAccount.dataSource = self
        destinationAccount.delegate = self
    }
    
    @IBAction func next(_ sender: UIButton) {
        
        
        // business logic
        transactionBuilder.destinationAccount = getKnownAccounts()[destinationAccount.selectedRow(inComponent: 0)]
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AmountViewController") as! AmountViewController
        viewController.transactionBuilder = transactionBuilder
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.getKnownAccounts()[row]
    }
    
    func getKnownAccounts() -> [String] {
        return AccountWebService().getKnownAccounts()
    }
}
