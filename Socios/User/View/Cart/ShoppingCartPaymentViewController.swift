//
//  ShoppingCartPaymentViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 22/09/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import LocalAuthentication
import LocalAuthentication
import FirebaseFirestore
import Social
import Firebase

class ShoppingCartPaymentViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    let db = Firestore.firestore()
    var user = Auth.auth().currentUser
    let storage = Storage.storage()
    var storageRef: StorageReference = StorageReference()
    var orderRef: StorageReference = StorageReference()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        getTotalPrice()
        // Do any additional setup after loading the view.
 
    }
    
    func confirmaPago() {
        db.collection("carts").whereField("user", isEqualTo: user!.uid).getDocuments() { [self]
            (querySnapshot, err)
            in guard let querySnapshot = querySnapshot else {
                print("error")
                return
            }
            if !querySnapshot.isEmpty && querySnapshot.documents.count > 0 {
                //Add to user Cart
                let cartInfo = querySnapshot.documents.first?.data()
                let cartId = cartInfo?["id"] as! String
                let doc = Firestore.firestore().collection("carts")
                var products = cartInfo?["products"] as? [Any]
                self.addToPurchases(productToAdd: products!)
                products?.removeAll()
//                for i in 0..<products!.count {
//                   products!.remove(at: i)
//
//                }
                doc.document(cartId).updateData(["products": products, "total": 0])
                self.totalLabel.text = "$0.0"
                self.performSegue(withIdentifier: "ConfirmedPurchase", sender: self)
            }else {
                print("Error")
                return
            }
        }
        
    }
    
    @IBAction func authenticateBiometrics(_ sender: Any) {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Mensaje", reply: {
            (success, err) in
                if (err != nil) {
                    print("Error al autenticar")
                } else {
                    DispatchQueue.main.async {
                        self.confirmaPago()
                    }
                }
            })
        }
    }
    
    func getTotalPrice(){
        db.collection("carts").whereField("user", isEqualTo: user!.uid).getDocuments() {
            (querySnapshot, err)
            in guard let querySnapshot = querySnapshot else {
                print("error")
                return
            }
            if !querySnapshot.isEmpty && querySnapshot.documents.count > 0 {
                //Add to user Cart
                let cartInfo = querySnapshot.documents.first?.data()
                let totalPrice = cartInfo?["total"] as! Double
                self.totalLabel.text = "$"+"\(totalPrice)"
                return
            }else {
                print("Error")
                return
            }
        }
        return
    }
    
    func addToPurchases(productToAdd: [Any]){
        db.collection("compras").whereField("user", isEqualTo: user!.uid).getDocuments() {
            (querySnapshot, err)
            in guard let querySnapshot = querySnapshot else {
                print("error")
                return
            }
            if !querySnapshot.isEmpty && querySnapshot.documents.count > 0 {
                //Add to user Purchases
                let purchaseInfo = querySnapshot.documents.first?.data()
                let purchaseId = purchaseInfo?["id"] as! String
                let doc = Firestore.firestore().collection("compras")
                var products = purchaseInfo?["products"] as? [Any]
                
                for productsInfo in productToAdd{
                    products?.append(productsInfo)
                    
                }
                print("TODO EL ARRAY DE COMPRAS: ", products)
                doc.document(purchaseId).updateData(["products": products])
            }else {
                let cart = Cart()
                cart.createPurchaseInFirestore(newProduct: productToAdd)
            }
        
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
