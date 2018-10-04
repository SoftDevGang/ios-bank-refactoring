//
//  AccountWebService.swift
//  MyBank
//
//  Created by Bastien DAVID on 04/10/2018.
//  Copyright © 2018 Soft Dev Gang. All rights reserved.
//

class AccountWebService {
    
    func getOwnAccounts() -> [String] {
        return ["current account", "savings", "shared account", "stocks"]
    }
    
    func getKnownAccounts() -> [String] {
        return ["mom", "darling", "landlord", "babysitter", "Freddy"]
    }
    
    func getBalance(_ account: String) -> Int {
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
    
    func getAccountCreditAllowed(_ account: String) -> Int {
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
    
    func getAccountType(_ account: String) -> AccountType {
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
}
