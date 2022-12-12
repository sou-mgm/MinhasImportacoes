//
//  TaxesCalculator.swift
//  MinhasImportacoes
//
//  Created by Matheus Matias on 01/12/22.
//

import Foundation

class TaxesCalculator{
    
    //MARK: Variaveis
    
    static let shared = TaxesCalculator()
    var dolar: dolar!
    var euro: euro!
    var bitcoin: bitcoin!
 
    // Moeda escolhida
    var chosenCurrency: String!
    var valueChosenCurrency: Double = 0.0
    
    //Cotacoes do Dolar
    var dolarNow: Double = 5.4
    var dolarHigh: Double = 5.6
    var dolarLow: Double = 5.2
    //Cotacoes do Euro
    var euroNow: Double = 5.35
    var euroHigh: Double = 5.7
    var euroLow: Double = 5.3
    //Cotacoes do Bitcoin
    var bitcoinNow: Double = 87.00 * 1000
    var bitcoinHigh: Double = 89.00 * 1000
    var bitcoinLow: Double = 80.00 * 1000
    // Valor de compra
    var shoppingValue: Double = 0.0
    //Peso do produto (libra)
    var weight: Double = 0.0
    // Valor por peso que será usado para calcular frete.
    var valueByWeight: Double = 18.97
    // Taxa de Estado
    var stateTax: Double = 7.0
    //IOF
    var iof: Double = 6.38
    // Frete
    var shipping: Double = 0.0
    //Variavel para formatar numeros
    let formatter = NumberFormatter()
    //variavel para verificar se os valores estao atualizado
    var isUpdateDolar: Bool = false
    var isUpdateEuro: Bool = false
    var isUpdateBitcoin: Bool = false
    
    
    
    //variaveis computadas
    var shoppingValueInReal: Double {
        return self.shoppingValueInReal * valueChosenCurrency
    }
    
    var stateTaxValue: Double {
        return shoppingValue * (stateTax / 100)
    }
    
    var iofValue: Double {
        return (shoppingValue + stateTax) * iof/100
    }
    

    
    
    //MARK: Funções
    
    func upDateValues(with isDolar:Bool, with isEuro: Bool, with isBitcoin: Bool){
        if isDolar {
                let DolarNow = Double(dolar.USDBRL.bid)
                dolarNow = DolarNow!
                
                let DolarLow = Double(dolar.USDBRL.low)
                dolarNow = DolarLow!
            
                let DolarHigh = Double(dolar.USDBRL.high)
                dolarNow = DolarHigh!
                isUpdateDolar = true
            }
        
        if isEuro {
            let EuroNow = Double(euro.EURBRL.bid)
                euroNow = EuroNow!
                
            let EuroLow = Double(euro.EURBRL.low)
                euroNow = EuroLow!
            
            let EuroHigh = Double(euro.EURBRL.high)
                euroNow = EuroHigh!
                isUpdateEuro = true
            }
        if isBitcoin {
            let BitcoinNow = Double(bitcoin.BTCBRL.bid) 
                bitcoinNow = BitcoinNow! * 1000
            
            let BitcoinLow = Double(bitcoin.BTCBRL.low)
                bitcoinLow = BitcoinLow! * 1000
            
            let BitcoinHigh = Double(bitcoin.BTCBRL.high)
                bitcoinHigh = BitcoinHigh! * 1000 
                isUpdateBitcoin = true
            }
        
    }
    
    // Verifica a moeda escolhida
    func currencyType(currencyType: String){
        if currencyType == "Dolar"{
            valueChosenCurrency = dolarNow
        }
        if currencyType == "Euro"{
            valueChosenCurrency = euroNow
        }
        if currencyType == "Bitcoin"{
            valueChosenCurrency = bitcoinNow
        }
    }
    
    // Valores de frete são apenas para parametro. Valores por libra foram estudos por conta própria com base na média de taxas de servico de empresas que redirecionam produtos para o Brasil.
    func calculateShipping(weight: Double) {
        valueByWeight = 18.97
        switch weight {
        case 0.0...1.99:
            shipping = valueByWeight
        case 2.0...11.99:
            valueByWeight = 11.93
            let total = valueByWeight * weight
            shipping = total
        case 12.0...20.0:
            valueByWeight = 10.30
            let total = valueByWeight * weight
            shipping = total
        default:
            valueByWeight = 9.18
            let total = valueByWeight * weight
            shipping = total
            
        }
    }

    
    func calculate (considerStateTax: Bool, usingCreditCard: Bool, considerShipping: Bool) -> Double{
        
        var finalValue = shoppingValue
        
        if considerStateTax {
            // Verifica se deve considera imposto dos EUA
            if chosenCurrency != "Dolar" {
                stateTax = 0.0
                finalValue += stateTaxValue
            } else {
                stateTax = 7.0
                finalValue += stateTaxValue
            }
        }
        if usingCreditCard {
            if chosenCurrency == "Dolar"  {
                stateTax = 7.0
                iof = 6.38
                finalValue += iofValue
            }
            if chosenCurrency == "Euro"{
                stateTax = 0.0
                iof = 6.38
                finalValue += iofValue
            }
            if chosenCurrency == "Bitcoin"{
                stateTax = 0.0
                iof = 0.0
                finalValue += iofValue
            }
        }
        if considerShipping{
            
            if chosenCurrency == "Dolar"  {
                finalValue += shipping
            }
            if chosenCurrency == "Euro"{
                finalValue += shipping
            }
            if chosenCurrency == "Bitcoin"{
                finalValue += shipping
            }
        }
        
        return finalValue * valueChosenCurrency
    }
    
  /*  func convertToDouble(_ string: String) -> Double {
        formatter.numberStyle = .none
        return formatter.number(from: string)!.doubleValue
    }
    
    */
    func convertToOptionalDouble(_ string: String) -> Double? {
        formatter.numberStyle = .none
        let optionalDouble = formatter.number(from: string)?.doubleValue
        return optionalDouble
    }
    
    func getFormattedValue(of value: Double, withCurrency currency: String) -> String {
        formatter.numberStyle = .currency
        formatter.currencySymbol = currency
        formatter.alwaysShowsDecimalSeparator = true
        return formatter.string(for: value)!
    }
    
    
    private init () {
        formatter.usesGroupingSeparator = true
    }
    
    
    
    
}
