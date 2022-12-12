//
//  MyImportsViewController.swift
//  MinhasImportacoes
//
//  Created by Matheus Matias on 05/12/22.
//

import UIKit

class MyImportsViewController: UIViewController {
    
    
    
    @IBOutlet weak var importsTableView: UITableView!
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    @IBOutlet weak var viInicial: UIView!
    
    @IBOutlet weak var btCreate: UIBarButtonItem!
    
    
    //Array de objetos importados para popular a table view
    var importedObjects: [ImportedObject] = []
    var indexNumber: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if loadingRest.finishedInitialization == false {
            inicialConfiguration()
            loadingRest.loadCurrency()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTable()
    }
    
    func reloadTable(){
        if let produtes = user_default.loadProdutes() {
            importedObjects = produtes
        }
        
        importsTableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSimulation"{
            let vc = segue.destination as! SimulatorViewController
            vc.produteName = importedObjects[indexNumber].produteName
            vc.weight = importedObjects[indexNumber].weight
            vc.selectedCurrencyType = importedObjects[indexNumber].currencyType
            vc.currencyQuote = importedObjects[indexNumber].currencyQuote
            vc.produtePrice = importedObjects[indexNumber].productPrice
            vc.produteShipping = importedObjects[indexNumber].productShipping
            vc.isNewProdute = false
        }
    }
    
    
    func inicialConfiguration(){
        viInicial.isHidden = false
        actInd.startAnimating()
        btCreate.isEnabled = false
       
        loadingRest.sleepTime(wait: 7) {
            self.actInd.stopAnimating()
            self.viInicial.isHidden = true
            self.btCreate.isEnabled = true
        }
        
    }
    
        
    
    
    
    @IBAction func createNewObject(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "newImportSegue", sender: self)
    }

    
}

  



extension MyImportsViewController: UITableViewDelegate, UITableViewDataSource {
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return importedObjects.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let importedObject = importedObjects[indexPath.row]
        cell.prepareCell(with: importedObject)

        return cell
    }
 
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexNumber = indexPath.row
        performSegue(withIdentifier: "showSimulation", sender: self)
    }

    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            importedObjects.remove(at: indexPath.row)
            user_default.produtes.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            user_default.salveProdutes()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}
