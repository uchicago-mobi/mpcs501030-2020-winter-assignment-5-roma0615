//
//  DataManager.swift
//  WhereInTheWorld
//
//  Created by Roma Bhattacharjee on 2/11/20.
//  Copyright © 2020 Roma Bhattacharjee. All rights reserved.
//

import Foundation

public class DataManager {
    
    public static let instance = DataManager()
    
    var favorites: [Place] = []
    
    fileprivate init() {
        
    }
    
    // https://www.hackingwithswift.com/read/12/2/reading-and-writing-basics-nsuserdefaults
    func loadAnnotationsFromPlist() {
        // read the favorites from userdefaults
        let defaults = UserDefaults.standard
        let data = defaults.object(forKey: "favorites") as? [Dictionary<String, Any>] ?? [Dictionary<String, Any>]()
        for datum in data {
            let name = datum["name"] as! String
            var desc = datum["desc"] as! String?
            if desc == "" {
                desc = nil
            }
            let lat = datum["lat"] as! Double
            let long = datum["long"] as! Double
            favorites.append(Place(name: name, description: desc, lat: lat, long: long))
        }
    }
    
    func saveFavorites() {
        // save the current list of favorites into userdefaults
        // save just the names
        var data: [Dictionary<String, Any>] = []
        for place in favorites {
            let datum = ["name": place.name, "desc": place.longDescription ?? "", "lat": place.coordinate.latitude, "long": place.coordinate.longitude] as [String : Any]
            data.append(datum)
        }
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: "favorites")
    }
    
    func addFavorite(_ ann: Place) {
        if !contains(ann) {
            favorites.append(ann)
            saveFavorites()
        }
    }
    func removeFavorite(_ ann: Place) {
        if let i = favorites.firstIndex(of: ann) {
            favorites.remove(at: i)
            saveFavorites()
        }
    }
    func contains(_ ann: Place) -> Bool {
        return favorites.contains(ann)
    }
    func contains(name: String) -> Bool {
        return favorites.map { $0.name }.contains(name)
    }
    func getFavorite(at index: Int) -> Place? {
        if index >= 0 && index < favorites.count {
            return favorites[index]
        } else {
            return nil
        }
    }
    func getFavorite(byName name: String) -> Place? {
        for place in favorites {
            if place.name == name {
                return place
            }
        }
        return nil
    }
    func numFavorites() -> Int {
        return favorites.count
    }
    
    
}
