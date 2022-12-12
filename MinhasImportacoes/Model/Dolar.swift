//
//  Dolar.swift
//  MinhasImportacoes
//
//  Created by Matheus Matias on 01/12/22.
//

import Foundation

struct dolar: Codable {
    var USDBRL: dataDolar
}

struct dataDolar: Codable {
    var code: String
    var codein: String
    var name: String
    var high: String
    var low: String
    var varBid: String
    var pctChange: String
    var bid: String
    var ask: String
    var timestamp: String
    var create_date: String
  
}
