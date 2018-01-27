//
//  Place.swift
//  Lugares del Mundo
//
//  Created by Luis Conde on 23/01/18.
//  Copyright © 2018 Luis Conde. All rights reserved.

import Foundation
import UIKit
import CoreData


class Place: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var type: String
    @NSManaged var location: String
    @NSManaged var image: NSData!
    @NSManaged var phone: String?
    @NSManaged var website: String?
    @NSManaged var rating: String!
    

    
}

