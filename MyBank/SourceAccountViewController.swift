//
//  SourceAccountViewController.swift
//  MyBank
//
//  Created by Bastien DAVID on 04/10/2018.
//  Copyright © 2018 Soft Dev Gang. All rights reserved.
//

import UIKit

class SourceAccountViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
    @IBOutlet weak var sourceAccount: UIPickerView!
    
    @IBAction func next(_ sender: UIButton) {
        
        let transactionBuilder = TransactionBuilder()
        
        // business logic
        transactionBuilder.sourceAccount = getOwnAccounts()[sourceAccount.selectedRow(inComponent: 0)]
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DestinationAccountViewController") as! DestinationAccountViewController
        viewController.transactionBuilder = transactionBuilder
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceAccount.dataSource = self
        sourceAccount.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return getOwnAccounts().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.getOwnAccounts()[row]
    }
    
    func getOwnAccounts() -> [String] {
        return AccountWebService().getOwnAccounts()
    }
}
