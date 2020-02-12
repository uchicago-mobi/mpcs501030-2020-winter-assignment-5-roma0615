//
//  Place.swift
//  WhereInTheWorld
//
//  Created by Roma Bhattacharjee on 2/11/20.
//  Copyright © 2020 Roma Bhattacharjee. All rights reserved.
//

import UIKit
import MapKit

// https://www.raywenderlich.com/548-mapkit-tutorial-getting-started
class Place: MKPointAnnotation {
    // name of the point of interest
    var name: String
    // description
    var longDescription: String?
    
    init(name: String, description: String?, lat: Double, long: Double) {
        self.name = name
        self.longDescription = description
        super.init()
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
}
