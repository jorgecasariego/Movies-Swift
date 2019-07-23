//
//  PDFViewController.swift
//  PeliculasWithMenu
//
//  Created by Jorge Casariego on 7/22/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    private let pdfUrlString: String
    private let pdfUrl: URL
    private let document: PDFDocument!
    private let outline: PDFOutline?
    private var pdfView = PDFView()
    private var thumbnailView = PDFThumbnailView()
    private var outlineButton = UIButton()
    private var dismissButton = UIButton()
    private var compartirButton = UIButton()
    
    init(pdfUrlString: String) {
        self.pdfUrlString = pdfUrlString
        self.pdfUrl = URL(string: pdfUrlString)!
        self.document = PDFDocument(url: pdfUrl)
        self.outline = document.outlineRoot
        pdfView.document = document
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPDFView()
        setupDismissButton()
        setupThumbnailView()
        setupOutlineButton()
        setupShareButton()
        
        /// Setting UIDocumentInteractionController delegate.
        documentInteractionController.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pdfView.frame = view.safeAreaLayoutGuide.layoutFrame
        let thumbanilHeight: CGFloat = 120
        thumbnailView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: thumbanilHeight))
    }
    
    private func setupPDFView() {
        view.addSubview(pdfView)
        pdfView.displayDirection = .horizontal
        pdfView.usePageViewController(true)
        pdfView.pageBreakMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pdfView.autoScales = true
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(toggleTools))
        pdfView.addGestureRecognizer(touch)
    }
    
    @objc func toggleTools() {
        if outlineButton.alpha != 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.outlineButton.alpha = 0
                self.thumbnailView.alpha = 0
                self.dismissButton.alpha = 0
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.outlineButton.alpha = 1
                self.thumbnailView.alpha = 1
                self.dismissButton.alpha = 1
            }, completion: nil)
        }
    }
    
    private func setupDismissButton() {
        dismissButton = UIButton(frame: .zero)
        dismissButton.layer.cornerRadius = 40/2
        dismissButton.setTitle("X", for: .normal)
        dismissButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        dismissButton.setTitleColor(.white, for: .normal)
        dismissButton.backgroundColor = .black
        dismissButton.alpha = 0.8
        
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: 10, bottom: 10, right: 10), size: .init(width: 40, height: 40))
        dismissButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    @objc private func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupThumbnailView() {
        thumbnailView.pdfView = pdfView
        thumbnailView.backgroundColor = UIColor(displayP3Red: 179/255, green: 179/255, blue: 179/255, alpha: 0.5)
        thumbnailView.layoutMode = .horizontal
        thumbnailView.thumbnailSize = CGSize(width: 80, height: 100)
        thumbnailView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        view.addSubview(thumbnailView)
    }
    
    private func setupOutlineButton() {
        outlineButton = UIButton(frame: .zero)
        outlineButton.layer.cornerRadius = 40/2
        outlineButton.setTitle("三", for: .normal)
        outlineButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        outlineButton.setTitleColor(.white, for: .normal)
        outlineButton.backgroundColor = .black
        outlineButton.alpha = 0.8
        
        view.addSubview(outlineButton)
        outlineButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 40, left: 10, bottom: 10, right: 10), size: .init(width: 40, height: 40))
        
        outlineButton.addTarget(self, action: #selector(toggleOutline(sender:)), for: .touchUpInside)
    }
    
    @objc private func toggleOutline(sender: UIButton) {
        
        guard let outline = self.outline else {
            print("PDF has no outline")
            return
        }
        
        let outlineViewController = OutlineTableViewController(outline: outline, delegate: self)
        outlineViewController.preferredContentSize = CGSize(width: 300, height: 400)
        outlineViewController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        let popoverPresentationController = outlineViewController.popoverPresentationController
        popoverPresentationController?.sourceView = outlineButton
        popoverPresentationController?.sourceRect = CGRect(x: sender.frame.width/2, y: sender.frame.height, width: 0, height: 0)
        popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popoverPresentationController?.delegate = self
        
        self.present(outlineViewController, animated: true, completion: nil)
    }
    
    let documentInteractionController = UIDocumentInteractionController()
    
    private func setupShareButton() {
        compartirButton = UIButton(frame: .zero)
        compartirButton.setTitle("Compartir", for: .normal)
        compartirButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        compartirButton.setTitleColor(.white, for: .normal)
        
        view.addSubview(compartirButton)
        compartirButton.anchor(top: dismissButton.topAnchor, leading: dismissButton.trailingAnchor, bottom: nil, trailing: outlineButton.leadingAnchor)
        
        compartirButton.addTarget(self, action: #selector(handleCompartir), for: .touchUpInside)
    }
    
    @objc private func handleCompartir() {
        /// Passing the remote URL of the file, to be stored and then opted with mutliple actions for the user to perform
        storeAndShare(withURLString: pdfUrlString)
    }
}

extension PDFViewController: OutlineDelegate {
    func goTo(page: PDFPage) {
        pdfView.go(to: page)
    }
}

extension PDFViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension PDFViewController {
    /// This function will set all the required properties, and then provide a preview for the document
    func share(url: URL) {
        documentInteractionController.url = url
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentPreview(animated: true)
    }
    
    /// This function will store your document to some temporary URL and then provide sharing, copying, printing, saving options to the user
    func storeAndShare(withURLString: String) {
        guard let url = URL(string: withURLString) else { return }
        /// START YOUR ACTIVITY INDICATOR HERE
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(response?.suggestedFilename ?? "fileName.png")
            do {
                try data.write(to: tmpURL)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                /// STOP YOUR ACTIVITY INDICATOR HERE
                self.share(url: tmpURL)
            }
            }.resume()
    }
}

extension PDFViewController: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        guard let navVC = self.navigationController else {
            return self
        }
        return navVC
    }
}

extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}
