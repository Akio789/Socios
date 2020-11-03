//
//  Productos.swift
//  Socios
//
//  Created by Manuel Ortiz on 02/11/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import Foundation

public struct Productos: Codable {
    
    var name: String
    var id: String
    var seller: String
    var price: Double
    var rating: Double
    var imageUrl: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        
        case name
        case id
        case seller
        case price = "price"
        case rating = "rating"
        case imageUrl
        case description
        
    }
    
    
    
}
