//
//  ImportedObject.swift
//  MinhasImportacoes
//
//  Created by Matheus Matias on 02/12/22.
//

//
import Foundation

// Criaçao de objeto para produtos importados

class ImportedObject: Codable {
    var produteName: String   //Nome
    var weight: Double         //peso
    var currencyType:String   // Tipo de moeda
    var currencyQuote:Double  //Cotacao
    var productPrice:Double   //preco do produto
    var stateTaxes:Double      //Taxas estaduais
    var iofValue:Double       // IOF
    var productShipping:Double //Frete
    var abbreviation: String
    
    init(produteName: String, weight: Double, currencyType: String, currencyQuote: Double, productPrice: Double, stateTaxes: Double, iofValue: Double, productShipping: Double, abbreviation: String) {
        self.produteName = produteName
        self.weight = weight
        self.currencyType = currencyType
        self.currencyQuote = currencyQuote
        self.productPrice = productPrice
        self.stateTaxes = stateTaxes
        self.iofValue = iofValue
        self.productShipping = productShipping
        self.abbreviation = abbreviation
    }
}
