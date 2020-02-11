//
//  ViewController.swift
//  WhereInTheWorld
//
//  Created by Roma Bhattacharjee on 2/10/20.
//  Copyright © 2020 Roma Bhattacharjee. All rights reserved.
//

import UIKit
import MapKit

struct RootData: Codable {
    var places: [PlaceData]?
    var region: [Double]?
}

struct PlaceData: Codable {
    var name: String
    var description: String?
    var lat: Double
    var long: Double
    var type: Int
}

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var detailView: DetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // customize map view
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42, longitude: -88), latitudinalMeters: 495000, longitudinalMeters: 190000)
        mapView.delegate = self
        loadPlacesData()
    }

    func loadPlacesData() {
        // https://useyourloaf.com/blog/using-swift-codable-with-property-lists/
        var data: RootData?
        // https://stackoverflow.com/questions/35118301/cant-get-plist-url-in-swift
        guard let filePath = Bundle.main.path(forResource: "Data", ofType: "plist") else { return }
        guard let contents = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return }
        let decoder = PropertyListDecoder()
        data = try? decoder.decode(RootData.self, from: contents)
        // create annotations
        if let places = data?.places {
            for place in places {
                print(place)
                let annotation = Place(name: place.name, description: place.description, lat: place.lat, long: place.long, type: place.type)
                mapView.addAnnotation(annotation)
            }
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // set the detail view's data to the annotation's data
        // the annotation view has a name and longDescription
        guard let ann = view.annotation as? Place else { return }
        detailView.show(ann.name, description: ann.longDescription)
    }
}
