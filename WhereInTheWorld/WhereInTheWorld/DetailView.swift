//
//  DetailView.swift
//  WhereInTheWorld
//
//  Created by Roma Bhattacharjee on 2/10/20.
//  Copyright © 2020 Roma Bhattacharjee. All rights reserved.
//

import UIKit

class DetailView: UIView {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionBox: UITextView!
    @IBOutlet var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 8
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
    }
    
    @IBAction func onFavoriteButton(_ sender: Any) {
        print("TOGGLED!")
        favoriteButton.isSelected.toggle()
    }
    

}
