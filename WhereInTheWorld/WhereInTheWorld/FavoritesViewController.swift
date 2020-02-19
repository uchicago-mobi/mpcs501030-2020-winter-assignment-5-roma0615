//
//  FavoritesViewController.swift
//  WhereInTheWorld
//
//  Created by Roma Bhattacharjee on 2/11/20.
//  Copyright © 2020 Roma Bhattacharjee. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    weak var delegate: PlacesFavoritesDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func onDismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FavoriteTableViewCell else { return }
        guard let ann = cell.annotation else { return }
        dismiss(animated: true) {
            self.delegate?.didSelectAnnotation(ann)
        }
    }
    
}
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        guard let ann = delegate?.getFavorite(at: indexPath.row) else { return cell }
        cell.label?.text = ann.name
        cell.annotation = ann
        return cell
    }
}
