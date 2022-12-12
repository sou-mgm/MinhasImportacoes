//
//  ImportsViewController.swift
//  MinhasImportacoes
//
//  Created by Matheus Matias on 01/12/22.
//

import UIKit

class NewImportViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var lbDolarNow: UILabel!
    @IBOutlet weak var lbEuroNow: UILabel!
    @IBOutlet weak var lbBitcoinNow: UILabel!
    @IBOutlet weak var tfProduteName: UITextField!
    @IBOutlet weak var tfProdutePrice: UITextField!
    @IBOutlet weak var tfWeight: UITextField!
    @IBOutlet weak var tfCurrencyType: UITextField!
    @IBOutlet weak var tfCurrencyQuote: UITextField!
    @IBOutlet weak var tfProductShipping: UITextField!
    //botoes
    @IBOutlet weak var btCurrencyQuoteNow: UIButton!
    @IBOutlet weak var btManualCurrencyQuote: UIButton!
    @IBOutlet weak var btCalculate: UIButton!
    @IBOutlet weak var lbAlertError: UILabel!
    
    
    
    //MARK: Variables
    
    var produteName: String = ""   //Nome
    var weight: Double = 0.0      //peso
    var selectedCurrencyType:String = ""  // Tipo de moeda
    var currencyQuote:Double = 0.0//Cotacao
    var produtePrice:Double = 0.0  //preco do produto
    var produteShipping: Double = 0.0 //Frete
    // Paleta de cores padroes
    var mainYellow = UIColor(named: "Palette - Yellow")
    var mainGreen3 = UIColor(named: "Palette - Green 3")
    var mainGreen4 = UIColor(named: "Palette - Green 4")
    // Tipos de moedas
    var currencyType: [String] = ["Dolar","Euro","Bitcoin"]
    // Realiza a criacao de um pickerView que selecao do tipo de moeda
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    // Variavel para processeguir com a simulaao
    var canShow: Bool = true
    
    
    //MARK: Default functions
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLabelValue()
        toolBar()
    }
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tfProduteName.resignFirstResponder()
        tfProdutePrice.resignFirstResponder()
        tfWeight.resignFirstResponder()
        tfCurrencyType.resignFirstResponder()
        tfCurrencyQuote.resignFirstResponder()
        tfProductShipping.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SimulatorViewController
        vc.produteName = produteName
        vc.weight = weight
        vc.selectedCurrencyType = selectedCurrencyType
        vc.currencyQuote = currencyQuote
        vc.produtePrice = produtePrice
        vc.produteShipping = produteShipping
        vc.isNewProdute = true
    }
    
    func showSimulator(){
        performSegue(withIdentifier: "simulateImportSegue", sender: self)
    }
    
    
    //MARK: Functions
    
    // Funcao para carrega o valor atual da moeda
    func loadLabelValue() {
        lbAlertError.isHidden = true
        // dolar
        if tc.isUpdateDolar {

            lbDolarNow.textColor = mainGreen3
        } else{
            lbDolarNow.textColor = mainYellow
        }
        lbDolarNow.text = tc.getFormattedValue(of: tc.dolarNow, withCurrency: "US$")

        // Euro
        if tc.isUpdateEuro {
            lbEuroNow.textColor = mainGreen3
        } else {
            lbEuroNow.textColor = mainYellow
        }
        lbEuroNow.text = tc.getFormattedValue(of: tc.euroNow, withCurrency: "EUR")

        // Bitcoin
        if tc.isUpdateEuro {
            lbBitcoinNow.textColor = mainGreen3
        } else {
            lbBitcoinNow.textColor = mainYellow
        }
        lbBitcoinNow.text = tc.getFormattedValue(of: (tc.bitcoinNow), withCurrency: "BTC")
    }


    //Funcao para criar uma barra de ferramentas para o picker view
    func toolBar(){
        //Cria uma barra de ferramentas para a pickerView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        // Definindo cor padrao
        toolBar.tintColor = mainGreen3
        // Cria um botao de cancelar
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        //Cria um botao de "feito"
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        // Cria um espacamento entre os botoes
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //add os botoes a toolbar
        toolBar.items = [btCancel,flexibleSpace,btDone]
        
        tfCurrencyType.inputView = pickerView
        tfCurrencyType.inputAccessoryView = toolBar
    
    }
    
    @objc func cancel(){
        tfCurrencyType.resignFirstResponder()
    }
    
    @objc func done(){
        tfCurrencyType.text = currencyType[pickerView.selectedRow(inComponent: 0)]
        calculateCurrentCurrencyQuote()
        tfCurrencyType.resignFirstResponder()
        calculateShipping()
    }
    
    
    //Funcao para apresentar a cotacao atual, caso o usuario escolha utilizar o formato automatico
    func calculateCurrentCurrencyQuote(){
        tfCurrencyQuote.isUserInteractionEnabled = false
        tfCurrencyQuote.textColor = mainGreen3
        if tfCurrencyType.text == "Dolar"{
            tfCurrencyQuote.text = tc.getFormattedValue(of: tc.dolarNow, withCurrency: "")
        }
        if tfCurrencyType.text == "Euro"{
            tfCurrencyQuote.text = tc.getFormattedValue(of: tc.euroNow, withCurrency: "")
        }
        if tfCurrencyType.text == "Bitcoin"{
            tfCurrencyQuote.text = tc.getFormattedValue(of: tc.bitcoinNow, withCurrency: "")
        }
    }
    
    // funcao para calcular o frete
    func calculateShipping(){
        
        
        if let currentyType = tfCurrencyType.text,  currentyType == "Bitcoin" {
            tfProductShipping.text = "0,0"
            lbAlertError.isHidden = false
            lbAlertError.text = "Não é possivel simular frete de compras com bitcoin"
            lbAlertError.textColor = mainGreen4
            loadingRest.sleepTime(wait: 3) {
                self.lbAlertError.textColor = .red
                self.lbAlertError.isHidden = true
            }
        } else {
            tfProductShipping.isUserInteractionEnabled = false
            lbAlertError.isHidden = true
            
            if let weight = tfWeight.text, !weight.isEmpty{
                let doubleWeight = tc.convertToOptionalDouble(weight)
                if let doubleWeight = doubleWeight {
                    tc.calculateShipping(weight: doubleWeight)
                    tfProductShipping.text = tc.getFormattedValue(of: tc.shipping, withCurrency:"")
                    tfProductShipping.textColor = mainGreen3
                } else {
                    lbAlertError.isHidden = false
                    lbAlertError.text = "Erro ao calcular frete,verifique o peso."
                    
                }
            } else {
                lbAlertError.isHidden = false
                lbAlertError.text = "Erro ao calcular frete,verifique o peso."
            }
            
        }
    }
        
        
    
    //funcao para verificar os valores inseridos,  e iniciar simulacao
    func startSimulate(){
        
        lbAlertError.isHidden = true
        canShow = true
        
        // Desembrulha o nome
        if tfProduteName.text != "" {
            produteName = tfProduteName.text!
            print(produteName)
        } else {
            simulatorError()
        }
         
        // Peso do produto
        // Desembrulha e verifica todas as possiveis condicoes de erro
        //Se o valor nao é vazio e se ele pode ser convertido para double
        if let weightText = tfWeight.text, !weightText.isEmpty {
            let doubleWeight = tc.convertToOptionalDouble(weightText)
            if let doubleWeight = doubleWeight {
                weight = doubleWeight
                print(weight)
            } else {
                simulatorError()
            }
        } else {
            simulatorError()
        }
         
        // Desembrulha a moeda selecionada
        if tfCurrencyType.text != "" {
            selectedCurrencyType = tfCurrencyType.text!
            print(selectedCurrencyType)
        }
        else {
            simulatorError()
        }
         
        // Cotacao da moeda
        // Desembrulha e verifica todas as possiveis condicoes de erro
        //Se o valor nao é vazio
        if let stringCurrencyQuote = tfCurrencyQuote.text, !stringCurrencyQuote.isEmpty{
            //Retira o "." de separacao caso esteja usando bitcoins
            let CurrencyQuote = stringCurrencyQuote.components(separatedBy: ["."]).joined()
            //Tenta converter para double
            let doubleCurrencyQuote = tc.convertToOptionalDouble(CurrencyQuote)
            // Verifica se é possivel desembrulhar
            if let doubleCurrencyQuote = doubleCurrencyQuote{
                currencyQuote = doubleCurrencyQuote
                print(currencyQuote)
            } else {
                simulatorError()
            }
        }else {
            simulatorError()
        }
    
        // Preco do produto
        // Desembrulha e verifica todas as possiveis condicoes de erro
        //Se o valor nao é vazio e se ele pode ser convertido para double
        if let ProdutePrice = tfProdutePrice.text, !ProdutePrice.isEmpty {
            let doubleProdutePrice = tc.convertToOptionalDouble(ProdutePrice)
            if let doubleProdutePrice = doubleProdutePrice {
                produtePrice = doubleProdutePrice
                print(produtePrice)
            } else {
                simulatorError()
            }
        }
        else {
            simulatorError()
        }
        
        // Frete do produto
        // Desembrulha e verifica todas as possiveis condicoes de erro
        //Se o valor nao é vazio e se ele pode ser convertido para double
        if let shipping = tfProductShipping.text, !shipping.isEmpty {
            let doubleShipping = tc.convertToOptionalDouble(shipping)
            if let doubleShipping = doubleShipping {
                produteShipping = doubleShipping
                print(produteShipping)
            } else {
                simulatorError()
            }
        }
            else {
            simulatorError()
        }
         
        if canShow == true {
            // Exibe a tela de simulacao
            showSimulator()
        }
       
    }
    
    //Funcao para apresentar erro ao usuario
    func simulatorError() {
        lbAlertError.isHidden = false
        lbAlertError.text = "Erro, verifique os valores antes de prosseguir."
        canShow = false
    }
    
    //MARK: Buttons
    
    // Botao para Cotacao atual
    @IBAction func currentCurrencyQuote(_ sender: UIButton) {
        calculateCurrentCurrencyQuote()
        
    }
    
    //Botao para Cotacao manual
    @IBAction func manualCurrencyQuote(_ sender: UIButton) {
       
        tfCurrencyQuote.textColor = mainYellow
        tfCurrencyQuote.isUserInteractionEnabled = true
        
    }
    
  
    
    @IBAction func automaticSimulateShipping(_ sender: UIButton) {
        calculateShipping()
    }

    @IBAction func manualShipping(_ sender: UIButton) {
        lbAlertError.isHidden = true
        tfProductShipping.isUserInteractionEnabled = true
        tfProductShipping.textColor = mainYellow
    }
    
    
    @IBAction func simulateImport(_ sender: UIButton) {
        
        startSimulate()
        
    }
    
    

}


//MARK: Extension Picker View


extension NewImportViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    // Defini a quantidade de componentes do PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Defini a quantidade de linhas do PickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyType.count
    }
    
    //Defini as informacoes de cada linha.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let currencyType = currencyType[row]
        return currencyType
    }
    
    
    
}
