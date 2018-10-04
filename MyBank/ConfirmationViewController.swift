//
//  ConfirmationViewController.swift
//  MyBank
//
//  Created by Bastien DAVID on 04/10/2018.
//  Copyright © 2018 Soft Dev Gang. All rights reserved.
//

import UIKit

class ConfirmationViewController : UIViewController {
    
    @IBOutlet weak var confirmation: UILabel!
    
    var transactionBuilder: TransactionBuilder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmation.text = "Transfert from \(transactionBuilder.sourceAccount!) to \(transactionBuilder.destinationAccount!) of \(transactionBuilder.amount!)"
        
    }
}
