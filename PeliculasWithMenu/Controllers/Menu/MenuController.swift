//
//  MenuController.swift
//  PeliculasWithMenu
//
//  Created by Jorge Casariego on 7/9/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

struct MenuItem {
    let icon: UIImage
    let title: String
}

// para mantener nuestro codigo mas limpio lo que hacemos es crear una extension y manejar aquí los click en la tabla del menu
extension MenuController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Tarea 1: Cerrar el menu (QUe se encuentra en BaseSliginController)
        let slidingController = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController
        //slidingController?.handleHide()
        
        // Tarea 2: Abrir los ViewControllers dependiendo de donde se hizo click
        // Para esta tarea es mejor realizar todo el control de clicks, menus y controllers dentro del BaseSlidingController
        slidingController?.didSelectMenuItem(indexPath: indexPath)
    }
}

class MenuController: UITableViewController {
    
    let menuItems = [
        MenuItem(icon: #imageLiteral(resourceName: "profile"), title: "Inicio"),
        MenuItem(icon: #imageLiteral(resourceName: "lists"), title: "Lista"),
        MenuItem(icon: #imageLiteral(resourceName: "bookmarks"), title: "Favoritos"),
        MenuItem(icon: #imageLiteral(resourceName: "moments"), title: "Momentos"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomMenuHeaderView()
        return headerView
    }
    
    // no hace falta definir una altura. Esto genera automaticamente a partir de cada una de las vistas dentro del header
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 200
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuItemcellTableViewCell(style: .default, reuseIdentifier: "cellId")
        
        let menuItem = menuItems[indexPath.row]
        cell.iconImageView.image = menuItem.icon
        cell.titleLabel.text = menuItem.title
        
        return cell
    }
    
}
