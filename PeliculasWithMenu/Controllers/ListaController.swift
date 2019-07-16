//
//  ListaController.swift
//  PeliculasWithMenu
//
//  Created by Jorge Casariego on 7/16/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

class ListaController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Lista"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.backgroundColor = .white
        let label = UILabel()
        label.text = "Lista"
        label.font = UIFont.systemFont(ofSize: 64)
        label.frame = view.frame
        label.textAlignment = .center
        
        view.addSubview(label)
    }
    
}
