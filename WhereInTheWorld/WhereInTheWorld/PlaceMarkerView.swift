//
//  PlaceMarkerView.swift
//  WhereInTheWorld
//
//  Created by Roma Bhattacharjee on 2/11/20.
//  Copyright © 2020 Roma Bhattacharjee. All rights reserved.
//

import UIKit
import MapKit

class PlaceMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            clusteringIdentifier = "Place"
            displayPriority = .defaultLow
            markerTintColor = .systemRed
            glyphImage = UIImage(systemName: "pin.fill")
        }
    }
}
