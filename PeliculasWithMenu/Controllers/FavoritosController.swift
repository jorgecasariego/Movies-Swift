//
//  FavoritosView.swift
//  PeliculasWithMenu
//
//  Created by Jorge Casariego on 7/16/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

class FavoritosController: UITableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Favorito \(indexPath.row)"
        
        return cell
    }
}
