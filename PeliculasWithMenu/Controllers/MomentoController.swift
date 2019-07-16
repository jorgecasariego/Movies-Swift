//
//  MomentosView.swift
//  PeliculasWithMenu
//
//  Created by Jorge Casariego on 7/16/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

class MomentoController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Momentos"
        
        let label = UILabel()
        label.text = "Momentos"
        label.font = UIFont.systemFont(ofSize: 64)
        label.frame = view.frame
        label.textAlignment = .center
        
        view.addSubview(label)

    }
    
}
