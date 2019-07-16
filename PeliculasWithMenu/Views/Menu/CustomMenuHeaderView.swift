//
//  CustomMenuHeaderView.swift
//  PeliculasWithMenu
//
//  Created by Jorge Casariego on 7/15/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

class CustomMenuHeaderView: UIView {
    
    let nameLabel = UILabel()
    let usernameLabel = UILabel()
    let estadisticasLabel = UILabel()
    let profileImageView = ProfileImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupComponentes()
        setupStackView()
    }
    
    fileprivate func setupComponentes() {
        // componente personalizado para nuestro Header
        nameLabel.text = "Nicole Kidman"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        usernameLabel.text = "@nicoleKid"
        estadisticasLabel.text = "100 Seguidores, 8982 Siguiendo"
        
        profileImageView.image = #imageLiteral(resourceName: "kid")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.clipsToBounds = true
        
        setupAttributedText()
    }
    
    fileprivate func setupAttributedText() {
        estadisticasLabel.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "100 ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)])
        attributedText.append(NSAttributedString(string: "Seguidores  ", attributes: [.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "7091 ", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "Siguiendo", attributes: [.foregroundColor: UIColor.black]))
        
        estadisticasLabel.attributedText = attributedText
    }
    
    fileprivate func setupStackView() {
        let rightSpacerView = UIView()
        
        let arrangedSubviews = [
            UIStackView(arrangedSubviews: [profileImageView, rightSpacerView]),
            nameLabel,
            usernameLabel,
            SpacerView(space: 16),
            estadisticasLabel
        ]
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 24, left: 24, bottom: 24, right: 24)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
