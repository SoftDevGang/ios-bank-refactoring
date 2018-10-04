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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let root = navigationController as! RootNavigationViewController
        confirmation.text = "Transfert from \(root.sourceAccount!) to \(root.destinationAccount!) of \(root.amount!)"
        
    }
}
