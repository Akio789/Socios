//
//  ProductDetailFromSearchViewController.swift
//  Socios
//
//  Created by Akio Olvera on 9/19/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Social
import Firebase
import WatchConnectivity

class ProductDetailFromSearchViewController: UIViewController, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //code
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        //code
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //code
    }
    

    
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productSeller: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var prodcuRating: UILabel!
    var miSesion: WCSession! = nil
    let db = Firestore.firestore()
    var user = Auth.auth().currentUser
    let storage = Storage.storage()
    var storageRef: StorageReference = StorageReference()
    var orderRef: StorageReference = StorageReference()
   
    
    var productDescriptionEntry: String = ""
    var productSellerEntry: String = ""
    var productPriceEntry: Double = 0
    var productRatingEntry: Double = 0
    var productimageUrl: String = ""
    var productNameA: String = ""
    var productId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        miSesion = WCSession.default
        miSesion.delegate = self
        miSesion.activate()
        self.orderRef = self.storageRef.child(productimageUrl)
        self.orderRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            print("Error al bajar la foto: \(error)")
          } else {
            self.productImage.image = UIImage(data: data!)
          }
        }
        
        productDescription.text = productDescriptionEntry
        productSeller.text = productSellerEntry
        productPrice.text = "$" + String(productPriceEntry)
        productName.text = productNameA
        prodcuRating.text = String(productRatingEntry)
    }
    
    
    
    @IBAction func enviarReloj(_ sender: Any) {
        var latitud: String!
        var longitud: String!
        var storeId: String!
//        var point: GeoPoint!
        db.collection("productos").whereField("id", isEqualTo: productId).getDocuments() {
            (querySnapshot, err)
            in guard let querySnapshot = querySnapshot else {
                print("error")
                return
            }
            if !querySnapshot.isEmpty && querySnapshot.documents.count > 0 {
                //Add to user Cart
                let productInfo = querySnapshot.documents.first?.data()
                storeId = productInfo?["storeId"] as? String
                self.db.collection("tiendas").whereField("id", isEqualTo: storeId).getDocuments() {
                    (querySnapshot, err)
                    in guard let querySnapshot = querySnapshot else {
                        print("Error")
                        return
                    }
                    if !querySnapshot.isEmpty && querySnapshot.documents.count > 0 {
                        let storeInfo = querySnapshot.documents.first?.data()
                        let tienda = storeInfo?["name"] as! String
                        let coords = storeInfo?["localization"] as! GeoPoint
                        latitud = String(coords.latitude)
                        longitud = String(coords.longitude)
                        let mensaje = ["Tienda": tienda,"Latitud":latitud,"Longitud":longitud]
                        print(mensaje)
                        self.miSesion.sendMessage(mensaje, replyHandler: nil, errorHandler: self.manejoError(err:))
                    }else{
                        print("Error retrieving information from store.")
                        return
                    }
                }
            }else {
                print("Error retrieving information from product.")
                return
            }
        }
        
        
        
  
        
    }
    
    func manejoError( err: Error)->Void{
        print(err.localizedDescription)
    }

    @IBAction func shareSocial(_ sender: Any) {
        let message = "Encuentra \(self.productNameA), solamente en \(self.productSellerEntry)."
        let actionSheet = UIAlertController(title: "", message: "Comparte el producto", preferredStyle: UIAlertController.Style.actionSheet)
        let tweetAction = UIAlertAction(title: "Comparte en Twitter", style: UIAlertAction.Style.default) { (action) in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                let twitterVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterVC?.setInitialText(message)
                twitterVC?.add(self.productImage.image)
                self.present(twitterVC!, animated: true, completion: nil)
            }
            else {
                self.alertUser("No tiene sesión en Twitter")
            }
        }
        let fbAction = UIAlertAction(title: "Comparte en Facebook", style: UIAlertAction.Style.default) { (action) in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                let fbVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                fbVC?.setInitialText(message)
                fbVC?.add(self.productImage.image)
                self.present(fbVC!, animated: true, completion: nil)
            }
            else {
                self.alertUser("No tiene sesión en Facebook")
            }
        }
        let moreAction = UIAlertAction(title: "Mas opciones", style: UIAlertAction.Style.default) { (action) in
            let activityViewController = UIActivityViewController(activityItems: [message, self.productImage.image], applicationActivities: nil)
         
            self.present(activityViewController, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel)
        actionSheet.addAction(tweetAction)
        actionSheet.addAction(fbAction)
        actionSheet.addAction(moreAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func alertUser(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
       self.present(alert, animated: true)
    }
    
    
    
    @IBAction func addProductToCart(_ sender: Any) {
        let newProduct: [String: Any] = ["name": self.productNameA, "id": self.productId, "seller": self.productSellerEntry, "price": self.productPriceEntry, "rating": self.productRatingEntry, "imageUrl": self.productimageUrl, "description": self.productDescriptionEntry]
        db.collection("carts").whereField("user", isEqualTo: user!.uid).getDocuments() {
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
                var prevTotal = cartInfo?["total"] as! Double
                let newProduct: [String: Any] = ["name": self.productNameA, "id": self.productId, "seller": self.productSellerEntry, "price": self.productPriceEntry, "rating": self.productRatingEntry, "imageUrl": self.productimageUrl, "description": self.productDescriptionEntry]
                products?.append(newProduct)
                let priceToAdd = newProduct["price"] as! Double
                let newTotal = prevTotal + priceToAdd
                doc.document(cartId).updateData(["products": products, "total": newTotal as Double])
            }else {
                let cart = Cart()
                let newProduct: [String: Any] = ["name": self.productNameA, "id": self.productId, "seller": self.productSellerEntry, "price": self.productPriceEntry, "rating": self.productRatingEntry, "imageUrl": self.productimageUrl, "description": self.productDescriptionEntry]
                cart.createCartInFirestore(newProduct: newProduct)
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let nextView = segue.destination as! CommentsTableViewController
        nextView.productIdEntry = productId
    }
}
