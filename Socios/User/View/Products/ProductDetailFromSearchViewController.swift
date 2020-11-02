//
//  ProductDetailFromSearchViewController.swift
//  Socios
//
//  Created by Akio Olvera on 9/19/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import Firebase
import Social


class ProductDetailFromSearchViewController: UIViewController {

    
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productSeller: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var prodcuRating: UILabel!
    
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
        downloadCartFromFirestore(user!.uid) { (cart) in

            if cart == nil {
                self.createNewCart()
            } else {
                cart!.productsId.append(self.productId)
                self.updateCart(cart: cart!, withValues: ["productsId" : cart!.productsId])
            }
        }
        
    }
    
    private func createNewCart(){

        let newCart = Cart()
        newCart.id = UUID().uuidString
        newCart.ownerId = user!.uid
        newCart.productsId = [self.productId]
        saveCartToFirestore(newCart)
    }
    
    private func updateCart(cart: Cart, withValues: [String : Any]) {
        updateCartInFirestore(cart, withValues: withValues) { (error) in
           if error != nil {
//               self.hud.textLabel.text = "Error: \(error!.localizedDescription)"
//               self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
//               self.hud.show(in: self.view)
//               self.hud.dismiss(afterDelay: 2.0)

               print("error updating basket", error!.localizedDescription)
           } else {
               
//               self.hud.textLabel.text = "Added to basket!"
//               self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
//               self.hud.show(in: self.view)
//               self.hud.dismiss(afterDelay: 2.0)
                 print("Added correctly")
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
