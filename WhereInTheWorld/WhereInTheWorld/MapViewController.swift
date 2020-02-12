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
    
    var selectedAnnotation: Place? = nil
    // https://dmitripavlutin.com/concise-initialization-of-collections-in-swift/
    var favorites: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // customize map view
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42, longitude: -88), latitudinalMeters: 495000, longitudinalMeters: 190000)
        mapView.delegate = self
        loadPlacesData()
        
        // set detail view delegate
        detailView.delegate = self
        
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
                let annotation = Place(name: place.name, description: place.description, lat: place.lat, long: place.long, type: place.type)
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    func show(_ annotation: Place) {
        selectedAnnotation = annotation
        detailView.show(annotation)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favorites" {
            // get the view controller of the destination
            let vc : FavoritesViewController = segue.destination as! FavoritesViewController
            // and set its delegate to self
            vc.delegate = self
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // set the detail view's data to the annotation's data
        // the annotation view has a name and longDescription
        guard let annotation = view.annotation as? Place else { return }
        show(annotation)
    }
}

extension MapViewController: PlacesFavoritesDelegate {
    var count: Int {
        get {
            favorites.count
        }
    }
    
    func didFavoriteAnnotation() {
        if let ann = selectedAnnotation {
            favorites.append(ann)
        }
    }
    func didUnfavoriteAnnotation() {
        if let ann = selectedAnnotation, let i = favorites.firstIndex(of: ann) {
            favorites.remove(at: i)
        }
    }
    func isFavorite(_ ann: Place) -> Bool {
        return favorites.contains(ann)
    }
    func getFavoriteAt(index: Int) -> Place {
        return favorites[index]
    }
    
    func didSelectAnnotation(_ annotation: Place) {
        // center the map on the annotation
        mapView.setCenter(annotation.coordinate, animated: true)
        mapView.selectAnnotation(annotation, animated: true)
        
        // and display it in detail view
        show(annotation)
    }
}
