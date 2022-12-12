//
//  MyImportsTableViewController.swift
//  MinhasImportacoes
//
//  Created by Matheus Matias on 01/12/22.
//

import UIKit

class MyImportsTableViewController: UITableViewController {
    /*
    //Array de objetos importados para popular a table view
    var importedObjects: [ImportedObject] = []
    var indexNumber: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //loadingRest.loadCurrency()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTable()
    }
    
    func reloadTable(){
        if let produtes = user_default.loadProdutes() {
            importedObjects = produtes
        }
        
        tableView.reloadData()
        
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
    
    @IBAction func createNewObject(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "newImportSegue", sender: self)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return importedObjects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let importedObject = importedObjects[indexPath.row]
        cell.prepareCell(with: importedObject)

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexNumber = indexPath.row
        performSegue(withIdentifier: "showSimulation", sender: self)
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
*/

}




