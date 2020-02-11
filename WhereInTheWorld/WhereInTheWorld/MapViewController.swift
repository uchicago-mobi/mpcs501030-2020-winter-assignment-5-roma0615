//
//  ViewController.swift
//  WhereInTheWorld
//
//  Created by Roma Bhattacharjee on 2/10/20.
//  Copyright © 2020 Roma Bhattacharjee. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var detailView: DetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // customize map view
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42, longitude: -88), latitudinalMeters: 495000, longitudinalMeters: 190000)
    }

}

