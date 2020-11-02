//
//  Product.swift
//  Socios
//
//  Created by Manuel Ortiz on 02/11/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import Foundation

class Product {
    
    var id: String!
    var shopId: String!
    var name: String!
    var description: String!
    var price: Double!
    var seller: String!
    var rating: Double!
    var imageUrl: String!
    var type: String!
    
    init() {
    }
    
    init(_dictionary: NSDictionary) {
        
        id = _dictionary["id"] as? String
        shopId = _dictionary["shopId"] as? String
        name = _dictionary["name"] as? String
        description = _dictionary["description"] as? String
        price = _dictionary["price"] as? Double
        seller = _dictionary["seller"] as? String
        rating = _dictionary["rating"] as? Double
        imageUrl = _dictionary["imageUrl"] as? String
        type = _dictionary["type"] as? String
    }
    
    
    func saveProductToFirestore(_ product: Product) {
        
        FirebaseReference(.Products).document(product.id).setData(productDictionaryFrom(product) as! [String : Any])
    }


    //MARK: Helper functions

    func productDictionaryFrom(_ product: Product) -> NSDictionary {
        
        return NSDictionary(objects: [product.id, product.shopId, product.name, product.description, product.price, product.seller, product.rating, product.imageUrl, product.type], forKeys: ["id" as NSCopying, "shopId" as NSCopying, "name" as NSCopying, "description" as NSCopying, "price" as NSCopying, "seller" as NSCopying, "rating" as NSCopying, "imageUrl" as NSCopying, "type" as NSCopying])
    }

}
