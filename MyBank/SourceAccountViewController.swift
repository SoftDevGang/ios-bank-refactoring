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
        
        let root = navigationController as! RootNavigationViewController
        root.sourceAccount = getKnownAccounts()[sourceAccount.selectedRow(inComponent: 0)]
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DestinationAccountViewController")
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
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.getKnownAccounts()[row]
    }
    
    func getKnownAccounts() -> [String] {
        return ["current account", "savings", "shared account", "stocks"]
    }
}
