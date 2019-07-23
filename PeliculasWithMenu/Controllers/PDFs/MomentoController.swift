//
//  MomentosView.swift
//  PeliculasWithMenu
//
//  Created by Jorge Casariego on 7/16/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit
import PDFKit

class MomentoController: UIViewController {
    let pdfView = PDFView(frame: .zero)
    var spinner = UIActivityIndicatorView(style: .gray)
    var fileURL: URL!
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Compartir", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleCompartir), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleCompartir() {
        let pdfFilePath = URL(string: "https://gahp.net/wp-content/uploads/2017/09/sample.pdf")
        let pdfData = NSData(contentsOf: pdfFilePath!)
        let activityVC = UIActivityViewController(activityItems: [pdfData!], applicationActivities: nil)
        
        present(activityVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Momentos"
        view.addSubview(spinner)
        view.addSubview(pdfView)
        view.addSubview(shareButton)

        spinner.fillSuperview()
        pdfView.fillSuperview()
        shareButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 100, right: 10), size: .init(width: 0, height: 50))
        
        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.spinner.startAnimating()
            self.loadPdf()
        }
        
        
        
    }
    
    func loadPdf() {
        if let url = URL(string: "https://gahp.net/wp-content/uploads/2017/09/sample.pdf") {
            fileURL = url
            if let pdfDocument = PDFDocument(url: url) {
                pdfView.displayMode = .singlePageContinuous
                pdfView.autoScales = true
                // pdfView.displayDirection = .horizontal
                pdfView.document = pdfDocument
                spinner.stopAnimating()
            }
        }
        
    }
    
}
