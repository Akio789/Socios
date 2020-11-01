//
//  Cart.swift
//  Socios
//
//  Created by Manuel Ortiz on 01/11/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import Foundation

class Cart {
    var id: String!
    var ownerId: String!
    var productsId: [String]!
    
    init(_dictionary: NSDictionary){
        id = _dictionary["objectId"] as? String
        ownerId = _dictionary["ownerId"] as? String
        productsId = _dictionary["productsId"] as? [String]
    }
//    let storage = Storage.storage()
//    let storageRef = storage.reference()
    
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
func saveBasketToFirestore(_ cart: Cart){
    
    FirebaseReference(.Cart).document(cart.id).setData(cartDictionaryFrom(cart) as! [String: Any])
    
    
    
}

//MARK: Helper Functions
func cartDictionaryFrom(_ cart: Cart) ->  NSDictionary {
    
    return NSDictionary(objects: [cart.id, cart.ownerId, cart.productsId],
           forKeys: ["objectId" as NSCopying, "userId" as NSCopying, "productsId" as NSCopying])
}


//MARK: - Update Cart in Firestore
func updateCartInFirestore(_ cart: Cart, withValues: [String: Any], completion: @escaping (_ error: Error?) -> Void) {
    
    FirebaseReference(.Cart).document(cart.id).updateData(withValues){ (error) in
        completion(error)
    }
}


