//
//  CurrencyExchangeViewController.swift
//  MinhasImportacoes
//
//  Created by Matheus Matias on 01/12/22.
//

import UIKit

class CurrencyExchangeViewController: UIViewController {
    
    
    //Titulo
    @IBOutlet weak var lbTitle: UILabel!
    // Dolar
    @IBOutlet weak var lbDolarNow: UILabel!
    @IBOutlet weak var lbDolarLow: UILabel!
    @IBOutlet weak var lbDolarHigh: UILabel!
    @IBOutlet var viDolarStatus: UIView!
    //Euro
    @IBOutlet weak var lbEuroNow: UILabel!
    @IBOutlet weak var lbEuroLow: UILabel!
    @IBOutlet weak var lbEuroHigh: UILabel!
    @IBOutlet weak var viEuroStatus: UIView!
    //Bitcoin
    @IBOutlet weak var lbBitcoinNow: UILabel!
    @IBOutlet weak var lbBitcoinLow: UILabel!
    @IBOutlet weak var lbBitcoinHigh: UILabel!
    @IBOutlet weak var viBitcoinStatus: UIView!
    // Indicacoes de status
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbAlert: UILabel!
    @IBOutlet weak var btReload: UIButton!
    
    
    @IBOutlet weak var viReload: UIView!
    @IBOutlet weak var actIndReload: UIActivityIndicatorView!
    
    
    var mainYellow = UIColor(named: "Palette - Yellow")
    var mainGreen3 = UIColor(named: "Palette - Green 3")
    var mainGreen4 = UIColor(named: "Palette - Green 4")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        loadLabelValue()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    func configuration(){
        viReload.isHidden = true
        actIndReload.stopAnimating()
        if tc.isUpdateDolar == false {
            actInd.startAnimating()
            lbStatus.text = "Aguardando internet"
            lbAlert.text = "Clique no botão para reconectar"
            btReload.isEnabled = true
        }
        if tc.isUpdateDolar == true {
            actInd.stopAnimating()
            lbStatus.text = "Atualizado"
            lbAlert.text = "Atualizado há pouco"
            btReload.isEnabled = false
        }
    }
    
    func tryReload(){
        viReload.isHidden = false
        actIndReload.startAnimating()
        loadingRest.sleepTime(wait: 8) {
            self.actIndReload.stopAnimating()
            self.viReload.isHidden = true
        }
    }
    
    func loadLabelValue() {
        
        // dolar
        if tc.isUpdateDolar {
            viDolarStatus.backgroundColor = mainGreen4
            
        } else{
            viDolarStatus.backgroundColor = mainYellow
            
        }
        lbDolarNow.text = tc.getFormattedValue(of: tc.dolarNow, withCurrency: "US$")
        lbDolarLow.text = tc.getFormattedValue(of: tc.dolarLow, withCurrency: "US$")
        lbDolarHigh.text = tc.getFormattedValue(of: tc.dolarHigh, withCurrency: "US$")
        
        //
        
        // Euro
        if tc.isUpdateEuro {
            viEuroStatus.backgroundColor = mainGreen4
            
        } else {
            viEuroStatus.backgroundColor = mainYellow
        }
        lbEuroNow.text = tc.getFormattedValue(of: tc.euroNow, withCurrency: "EUR")
        lbEuroLow.text = tc.getFormattedValue(of: tc.euroLow, withCurrency: "EUR")
        lbEuroHigh.text = tc.getFormattedValue(of: tc.euroHigh, withCurrency: "EUR")
        
        
        // Bitcoin
        if tc.isUpdateEuro {
            viBitcoinStatus.backgroundColor = mainGreen4
            
        } else {
            viBitcoinStatus.backgroundColor = mainYellow
        }
        lbBitcoinNow.text = tc.getFormattedValue(of: (tc.bitcoinNow), withCurrency: "BTC")
        lbBitcoinLow.text = tc.getFormattedValue(of: (tc.bitcoinLow), withCurrency: "BTC")
        lbBitcoinHigh.text = tc.getFormattedValue(of: (tc.bitcoinHigh), withCurrency: "BTC")
    }
    
    
    
    @IBAction func reloadValues(_ sender: UIButton) {
        loadingRest.loadCurrency()
        tryReload()
        loadingRest.sleepTime(wait: 8) {
            self.configuration()
            self.loadLabelValue()
        }
       
    }
    
}
