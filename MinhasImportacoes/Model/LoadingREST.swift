//
//  LoadingREST.swift
//  MinhasImportacoes
//
//  Created by Matheus Matias on 03/12/22.
//

import Foundation
import UIKit

class LoadingRest: UIViewController {
    static let shared = LoadingRest()
    
    let group = DispatchGroup()
    var isDolar: Bool = false
    var isEuro: Bool = false
    var isBitcoin: Bool = false
    
    var finishedInitialization: Bool = false
    
    func sleepTime(wait: Int, completing: @escaping() -> Void){
        let deadline = DispatchTime.now() + .seconds(wait)
        DispatchQueue.main.asyncAfter(deadline: deadline, execute: completing)
    }
    
    func loadCurrency(){
        finishedInitialization = false
        loadDolar()
        loadEuro()
        loadBitcoin()
        group.notify(queue: .main) { [self] in
            print("Grupo noficado")
            finishedInitialization = true
            self.tc.upDateValues(with: isDolar, with: isEuro, with: isBitcoin)
        }
    }
    
    func loadDolar(){
        group.enter()
        print("enter group dolar")
        REST.loadDolar { (dolar) in
            self.tc.dolar = dolar
            self.isDolar = true
        } onError: { (loadError) in
            print(loadError)
        }
        sleepTime(wait: 6) {
            print("leave group dolar")
            self.group.leave()
        }
        
    }
    
    
    func loadEuro(){
        group.enter()
        print("enter group euro")
        REST.loadEuro { euro in
            self.tc.euro = euro
            self.isEuro = true
        } onError: { loadError in
            print (loadError)
        }
        sleepTime(wait: 6) {
            print("leave group euro")
            self.group.leave()
        }
    }
    
    
    func loadBitcoin(){
        group.enter()
        print("enter group bitcoin")
        REST.loadBitcoin { bitcoin in
            self.tc.bitcoin = bitcoin
            self.isBitcoin = true
        } onError: { loadError in
            print (loadError)
            
        }
        sleepTime(wait: 6) {
            print("leave group bitcoin")
            self.group.leave()
        }
    }
    
    func teste(){
        print(tc.dolarNow)
    }
    
    
    
    
}
