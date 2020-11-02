//
//  FirebaseCollectionReference.swift
//  Socios
//
//  Created by Manuel Ortiz on 01/11/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Shops
    case Products
    case Cart
    
}

//let storage = Storage.storage()
//let storageRef = storage.reference()


func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    
    
    return Firestore.firestore().collection(collectionReference.rawValue)
    
    
}

