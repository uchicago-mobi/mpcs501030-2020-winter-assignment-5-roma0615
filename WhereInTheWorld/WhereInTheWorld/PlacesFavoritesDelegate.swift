//
//  PlacesFavoritesDelegate.swift
//  WhereInTheWorld
//
//  Created by Roma Bhattacharjee on 2/11/20.
//  Copyright © 2020 Roma Bhattacharjee. All rights reserved.
//

import Foundation

protocol PlacesFavoritesDelegate: class {
    var count: Int { get }
    func didFavoriteAnnotation()
    func didUnfavoriteAnnotation()
    func didSelectAnnotation(_ annotation: Place)
    func isFavorite(_ ann: Place) -> Bool
    func getFavorite(at index: Int) -> Place?
}
