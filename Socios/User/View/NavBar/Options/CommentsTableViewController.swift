//
//  CommentsTableViewController.swift
//  Socios
//
//  Created by Akio Olvera on 9/30/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import Firebase

class CommentsTableViewController: UITableViewController {

    var commentsEntry: Array<[String: Any]> = []
    var productIdEntry: String = ""
    var shopIdEntry: String = ""
    let db = Firestore.firestore()
    var user = Auth.auth().currentUser
    var comments: Array<[String : Any]> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 75
        var searchBy = "productId"
        var idToSearch = productIdEntry
        if productIdEntry.isEmpty {
            searchBy = "shopId"
            idToSearch = shopIdEntry
        }
        db.collection("comments").whereField(searchBy, isEqualTo: idToSearch).getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            if !querySnapshot!.isEmpty {
                self.comments = querySnapshot!.documents.first!.data()["comments"] as? Array<[String : Any]> ?? []
                self.tableView.reloadData()
            }
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
        return comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comments", for: indexPath) as! CommentsTableViewCell

        // Configure the cell...
        cell.comment.text = comments[indexPath.row]["text"] as! String
        cell.user.text = comments[indexPath.row]["user"] as! String
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
