//
//  PersonalizedSearchResultTableViewController.swift
//  Socios
//
//  Created by Akio Olvera on 9/19/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit

class PersonalizedSearchResultTableViewController: UITableViewController, UISearchResultsUpdating {
    let direccionUrl = "http://martinmolina.com.mx/202013/Equipo3/data/playeras.json"
    var response: [Any]?
    var filteredData = [Any]()
    let searchController = UISearchController(searchResultsController: nil)
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" {
            filteredData = response!
        } else {
            filteredData = response!.filter{
                let itemObject = $0 as! [String:Any]
                let s: String = itemObject["name"] as! String;
                return(s.lowercased().contains(searchController.searchBar.text!.lowercased())) }
        }
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.rowHeight = 100
        
        if let url = URL(string: direccionUrl) {
            do {
            //let contents = try String(contentsOf: url)
            //print contents
            let data = try? Data(contentsOf: url)
            response = try! JSONSerialization.jsonObject(with: data!) as? [Any]
            filteredData = response!
            searchController.searchResultsUpdater = self
            searchController.dimsBackgroundDuringPresentation = false
            searchController.hidesNavigationBarDuringPresentation = false
            definesPresentationContext = true
            tableView.tableHeaderView = searchController.searchBar
            } catch {
            // contents could not be loaded
            print("contents could not be loaded")
            }
        } else{
            // the URL was bad!
            print("the URL was bad!")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personalizedSearchResult", for: indexPath) as! PersonalizedSearchTableViewCell

        // Configure the cell...
        let productObject = filteredData[indexPath.row] as! [String: Any]
        cell.productName.text = productObject["name"] as! String
        cell.price.text = String( productObject["price"] as! Float)
        cell.seller.text = productObject["seller"] as! String
        let imageUrl = URL(string: "http://martinmolina.com.mx/202013/Equipo3/roberta.jpg")
        let image = try? Data(contentsOf: imageUrl!)
        cell.cellImage.image = UIImage(data: image!)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let nextView = segue.destination as! ProductDetailViewController
        let index = self.tableView.indexPathForSelectedRow?.row
        let productObject = filteredData[index!] as! [String: Any]
        nextView.productDescriptionEntry = productObject["description"] as! String
    }
}
