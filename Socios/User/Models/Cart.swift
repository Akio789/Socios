//
//  Cart.swift
//  Socios
//
//  Created by Manuel Ortiz on 01/11/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase



class Cart {
    var id: String!
    var ownerId: String!
    var productsId: [String]!
    let db = Firestore.firestore()
    var user = Auth.auth().currentUser
    let storage = Storage.storage()

    
    
    init(){
        
    }
    
    init(_dictionary: NSDictionary){
        id = _dictionary["id"] as? String
        ownerId = _dictionary["ownerId"] as? String
        productsId = _dictionary["productsId"] as? [String]
        
    }
    
    func createCartInFirestore(newProduct: [String: Any]) {

        let cartId = UUID().uuidString
        db.collection("carts").document(cartId).setData(["products": [newProduct], "id": cartId, "user": self.user!.uid, "total": newProduct["price"]])
        
    }

}


//MARK: - Download Products
func downloadCartFromFirestore(_ ownerId: String, completion: @escaping (_ cart: Cart?)->Void) {
    
    FirebaseReference(.Cart).whereField("userId", isEqualTo: ownerId).getDocuments { (snapshot, error) in
        guard let snapshot = snapshot else {
            completion(nil)
            return
        }
        
        if !snapshot.isEmpty && snapshot.documents.count > 0 {
            let cart = Cart(_dictionary: snapshot.documents.first!.data() as NSDictionary)
            completion(cart)
        } else {
            completion(nil)
        }
    }
}
//MARK: Save to Firebase
func saveCartToFirestore(_ cart: Cart){
    
    FirebaseReference(.Cart).document(cart.id).setData(cartDictionaryFrom(cart) as! [String: Any])
    
}

//MARK: Helper Functions
func cartDictionaryFrom(_ cart: Cart) ->  NSDictionary {
    
    return NSDictionary(objects: [cart.id, cart.ownerId, cart.productsId],
           forKeys: ["id" as NSCopying, "userId" as NSCopying, "productsId" as NSCopying])
}


//MARK: - Update Cart in Firestore
func updateCartInFirestore(_ cart: Cart, withValues: [String: Any], completion: @escaping (_ error: Error?) -> Void) {
    
    FirebaseReference(.Cart).document(cart.id).updateData(withValues){ (error) in
        completion(error)
    }
}

//MARK: - Create New Cart when user is new






