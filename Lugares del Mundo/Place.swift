//
//  Place.swift
//  Lugares del Mundo
//
//  Created by Luis Conde on 23/01/18.
//  Copyright © 2018 Luis Conde. All rights reserved.

import Foundation
import UIKit


class Place: NSObject {
    
    var name: String!
    var type: String!
    var location: String!
    var image: UIImage!
    var phone: String!
    var website: String!
    var rating: String = "rating"
    
    init(name: String, type: String, location: String, image: UIImage?, phone: String, website: String) {
        
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.phone = phone
        self.website = website
        
    }
    
}

