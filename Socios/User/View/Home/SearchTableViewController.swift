//
//  PersonalizedSearchResultTableViewController.swift
//  Socios
//
//  Created by Akio Olvera on 9/19/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import Firebase

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var response: [Any]?
    var filteredData = [Any]()
    let searchController = UISearchController(searchResultsController: nil)
    
    let db = Firestore.firestore()
    var user = Auth.auth().currentUser
    let storage = Storage.storage()
    var storageRef: StorageReference = StorageReference()
    var orderRef: StorageReference = StorageReference()
    
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
        
        self.tableView.rowHeight = 100
        db.collection("productos").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            self.response = []
            for document in querySnapshot!.documents {
                var documentData = document.data()
                documentData["id"] = document.documentID
                self.response?.append(documentData)
                document.documentID
            }
            self.filteredData = self.response!
            self.tableView.reloadData()
            self.searchController.searchResultsUpdater = self
            self.searchController.dimsBackgroundDuringPresentation = false
            self.searchController.hidesNavigationBarDuringPresentation = false
            self.definesPresentationContext = true
            self.tableView.tableHeaderView = self.searchController.searchBar
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath) as! SearchTableViewCell

        // Configure the cell...
        let productObject = filteredData[indexPath.row] as! [String: Any]
        cell.productName.text = productObject["name"] as! String
        cell.price.text = String( productObject["price"] as! Float)
        cell.seller.text = "Vendedor: \(productObject["seller"] as! String)"
        self.orderRef = self.storageRef.child(productObject["imageUrl"] as! String)
        self.orderRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            print("Error al bajar la foto: \(error)")
          } else {
            cell.cellImage.image = UIImage(data: data!)
          }
        }

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
        let nextView = segue.destination as! ProductDetailFromSearchViewController
        let index = self.tableView.indexPathForSelectedRow?.row
        let productObject = filteredData[index!] as! [String: Any]
        nextView.productDescriptionEntry = productObject["description"] as! String
        let productObject2 = filteredData[index!] as! [String: Any]
        nextView.productSellerEntry = productObject2["seller"] as! String
        let productObject3 = filteredData[index!] as! [String: Any]
        nextView.productPriceEntry = productObject3["price"] as! Double
         let productObject4 = filteredData[index!] as! [String: Any]
         nextView.productRatingEntry = productObject4["rating"] as! Double
        let productObject5 = filteredData[index!] as! [String: Any]
        nextView.productimageUrl = productObject5["imageUrl"] as! String
        let productObject6 = filteredData[index!] as! [String: Any]
        nextView.productNameA = productObject6["name"] as! String
        let productObject7 = filteredData[index!] as! [String: Any]
        nextView.productId = productObject["id"] as! String
    }
}
