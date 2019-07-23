//
//  ListaController.swift
//  PeliculasWithMenu
//
//  Created by Jorge Casariego on 7/16/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit
import WebKit

class ListaController: UIViewController, UIWebViewDelegate {
    
    let openButton: UIButton = {
        let button = UIButton()
        button.setTitle("Abrir PDF", for: .normal)
        button.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        button.backgroundColor = .red
        
        return button
    }()
    
    @objc func handleOpen() {
        let pdfViewController = PDFViewController(pdfUrlString: "http://www.aena.es/csee/ccurl/771/908/Guia%20turistica%20Barcelona.pdf")
        present(pdfViewController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Lista"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        
        view.addSubview(openButton)
        openButton.fillSuperview()
    }
    
}
