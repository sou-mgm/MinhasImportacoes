//
//  TableViewCell.swift
//  MinhasImportacoes
//
//  Created by Matheus Matias on 01/12/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBOutlet weak var lbProduteName: UILabel!
    @IBOutlet weak var lbProdutePrice: UILabel!
    @IBOutlet weak var lbCurrencyType: UILabel!
    
    
    func prepareCell (with importedObject: ImportedObject){
        
        lbProduteName.text = importedObject.produteName
        lbProdutePrice.text = taxesCalculator.getFormattedValue(of: importedObject.productPrice, withCurrency: importedObject.abbreviation)
        lbCurrencyType.text = importedObject.currencyType
    }
    
}

