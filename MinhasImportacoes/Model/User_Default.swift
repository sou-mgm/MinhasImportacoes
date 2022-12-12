//
//  UserDefault.swift
//  MinhasImportacoes
//
//  Created by Matheus Matias on 05/12/22.
//

import Foundation
import UIKit

class User_Default: UIViewController {
    static let shared = User_Default()
    
    let ud = UserDefaults.standard
    var produtes: [ImportedObject] = []
    
    
        
        func loadProdutes() -> [ImportedObject]? {
            if let importedObjectsData = ud.data(forKey: "importedObject") {
                do{
                    let produtesData = try JSONDecoder().decode([ImportedObject].self, from: importedObjectsData)
                    produtes = produtesData
                }catch{
                    print(error.localizedDescription)
                }
            }
            return produtes
        }
    
    func salveProdutes(){
        let json = try? JSONEncoder().encode(produtes)
        ud.set(json, forKey: "importedObject")
    }
        
    
}
