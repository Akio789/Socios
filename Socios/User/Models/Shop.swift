//
//  Shop.swift
//  Socios
//
//  Created by Manuel Ortiz on 02/11/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import Foundation

class Shop {
    
    var id: String
    var name: String
    var description: String
    var imageUrl: String
    
    init(_name: String, _imageUrl: String, _description: String) {
        
        id = ""
        name = _name
        description = _description
        imageUrl = _imageUrl
    }
    
    init(_dictionary: NSDictionary) {
        id = _dictionary["id"] as! String
        name = _dictionary["name"] as! String
        description = _dictionary["description"] as! String
        imageUrl = _dictionary["imageUrl"] as! String
        
    }
    
    func saveShopToFirebase(_ shop: Shop) {
        
        let id = UUID().uuidString
        shop.id = id
        
        FirebaseReference(.Shops).document(id).setData(shopDictionaryFrom(shop) as! [String : Any])
    }


    //MARK: Helpers

    func shopDictionaryFrom(_ shop: Shop) -> NSDictionary {
        
        return NSDictionary(objects: [shop.id, shop.name, shop.description, shop.imageUrl], forKeys: ["id" as NSCopying, "name" as NSCopying, "description" as NSCopying, "imageUrl" as NSCopying])
    }
    
    func downloadCategoriesFromFirebase(completion: @escaping (_ shopArray: [Shop]) -> Void) {
        var shopArray: [Shop] = []
        FirebaseReference(.Shops).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {
                completion(shopArray)
                return
            }
            
            if !snapshot.isEmpty {
                for shopDict in snapshot.documents {
                    shopArray.append(Shop(_dictionary: shopDict.data() as NSDictionary))
                }
            }
            completion(shopArray)
        }
    }

    //use only one time
//    func createCategorySet() {
//
//        let womenClothing = Category(_name: "Women's Clothing & Accessories", _imageName: "womenCloth")
//        let footWaer = Category(_name: "Footwaer", _imageName: "footWaer")
//        let electronics = Category(_name: "Electronics", _imageName: "electronics")
//        let menClothing = Category(_name: "Men's Clothing & Accessories" , _imageName: "menCloth")
//        let health = Category(_name: "Health & Beauty", _imageName: "health")
//        let baby = Category(_name: "Baby Stuff", _imageName: "baby")
//        let home = Category(_name: "Home & Kitchen", _imageName: "home")
//        let car = Category(_name: "Automobiles & Motorcyles", _imageName: "car")
//        let luggage = Category(_name: "Luggage & bags", _imageName: "luggage")
//        let jewelery = Category(_name: "Jewelery", _imageName: "jewelery")
//        let hobby =  Category(_name: "Hobby, Sport, Traveling", _imageName: "hobby")
//        let pet = Category(_name: "Pet products", _imageName: "pet")
//        let industry = Category(_name: "Industry & Business", _imageName: "industry")
//        let garden = Category(_name: "Garden supplies", _imageName: "garden")
//        let camera = Category(_name: "Cameras & Optics", _imageName: "camera")
//
//        let arrayOfCategories = [womenClothing, footWaer, electronics, menClothing, health, baby, home, car, luggage, jewelery, hobby, pet, industry, garden, camera]
//
//        for category in arrayOfCategories {
//            saveCategoryToFirebase(category)
//        }
//
//    }
}
