//
//  SimulatorViewController.swift
//  MinhasImportacoes
//
//  Created by Matheus Matias on 01/12/22.
//

import UIKit



class SimulatorViewController: UIViewController {
    
    
    @IBOutlet weak var lbProductName: UILabel!
    @IBOutlet weak var lbWeight:  UILabel!
    @IBOutlet weak var lbCurrencyType: UILabel!
    @IBOutlet weak var lbCurrencyQuote: UILabel!
    
    @IBOutlet weak var swStateTax: UISwitch!
    @IBOutlet weak var swUsingCreditCard: UISwitch!
    @IBOutlet weak var swShipping: UISwitch!
    
    @IBOutlet weak var lbProductPrice: UILabel!
    @IBOutlet weak var lbStateTax: UILabel!
    @IBOutlet weak var lbIOF: UILabel!
    @IBOutlet weak var lbProductShipping: UILabel!

    @IBOutlet weak var lbTotalValueInReal: UILabel!
    
    @IBOutlet weak var btSalve: UIBarButtonItem!
    
    
    
    var produteName: String = ""   //Nome
    var weight: Double = 0.0      //peso
    var selectedCurrencyType:String = ""  // Tipo de moeda
    var currencyQuote:Double = 0.0//Cotacao
    var produtePrice:Double = 0.0  //preco do produto
    var produteShipping: Double = 0.0 //Frete
    var abbreviation: String = ""
    
    var isNewProdute: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateTaxes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newProdute()
    }

    func calculateTaxes(){
        
        abbreviationVerification()
        lbProductName.text = produteName
        lbWeight.text = tc.getFormattedValue(of: weight, withCurrency: "lb")
        lbCurrencyType.text = selectedCurrencyType
        lbCurrencyQuote.text = tc.getFormattedValue(of: currencyQuote, withCurrency: abbreviation)
        
        tc.chosenCurrency = selectedCurrencyType
        tc.valueChosenCurrency = currencyQuote
        tc.shoppingValue = produtePrice
        tc.shipping = produteShipping
        
        let final = tc.calculate(considerStateTax: swStateTax.isOn, usingCreditCard: swUsingCreditCard.isOn, considerShipping: swShipping.isOn)
        
        lbProductPrice.text = tc.getFormattedValue(of: tc.shoppingValue, withCurrency: abbreviation)
        lbStateTax.text = tc.getFormattedValue(of: tc.stateTaxValue, withCurrency: abbreviation)
        lbIOF.text = tc.getFormattedValue(of: tc.iofValue, withCurrency: abbreviation)
        lbProductShipping.text = tc.getFormattedValue(of: tc.shipping, withCurrency: abbreviation)
        
        lbTotalValueInReal.text = tc.getFormattedValue(of: final, withCurrency: "R$")
    }
    
    func abbreviationVerification() {
        if selectedCurrencyType == "Dolar"{
           abbreviation = "US$"
        }
        if selectedCurrencyType == "Euro"{
            abbreviation = "EUR"
        }
        if selectedCurrencyType == "Bitcoin"{
            abbreviation = "BTC"
        }
    }
    
    func newProdute(){
        if isNewProdute == true {
            btSalve.isEnabled = true
            btSalve.title = "Salvar"
        } else {
            btSalve.isEnabled = false
            btSalve.title = ""
        }
         
    }
    
    
    @IBAction func swStateTax(_ sender: UISwitch) {
        calculateTaxes()
    }
    
    
    @IBAction func swUsingCreditCard(_ sender: UISwitch) {
        calculateTaxes()
    }
    
    @IBAction func swShipping(_ sender: UISwitch) {
        calculateTaxes()
    }
    
    
    
    @IBAction func salveImportedObject(_ sender: UIBarButtonItem) {
        
   
        let newProdute = ImportedObject(produteName: produteName, weight: weight, currencyType: selectedCurrencyType, currencyQuote: currencyQuote, productPrice: produtePrice, stateTaxes: tc.stateTaxValue, iofValue: tc.iofValue, productShipping: tc.shipping, abbreviation: abbreviation)
        
        user_default.produtes.append(newProdute)
        user_default.salveProdutes()
        let navigation = navigationController
        navigation?.popToRootViewController(animated: true)
        
       
    }
    
    
    
}
