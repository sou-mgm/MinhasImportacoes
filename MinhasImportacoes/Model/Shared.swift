//
//  Shared.swift
//  MinhasImportacoes
//
//  Created by Matheus Matias on 01/12/22.
//


import UIKit

extension UIViewController {
    var tc: TaxesCalculator {
        return TaxesCalculator.shared
    }
   
    var loadingRest: LoadingRest {
        return LoadingRest.shared
    }
    
    var user_default: User_Default {
        return User_Default.shared
    }
    
    
    
}

extension UITableViewCell {
    var taxesCalculator: TaxesCalculator {
        return TaxesCalculator.shared
    }
}
