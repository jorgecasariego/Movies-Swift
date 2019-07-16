//
//  MoviewCell.swift
//  PeliculasWithMenu
//
//  Created by Jorge Casariego on 7/16/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

class MoviewCell: UITableViewCell {
    
    let tituloPeliculaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        
        return label
    }()
    
    let imagenPeliculaView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let sinopsisPeliculaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(imagenPeliculaView)
        addSubview(tituloPeliculaLabel)
        addSubview(sinopsisPeliculaLabel)
        
        imagenPeliculaView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 20, left: 20, bottom: 20, right: 20), size: .init(width: 120, height: 0))
        
        tituloPeliculaLabel.anchor(top: imagenPeliculaView.topAnchor, leading: imagenPeliculaView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20))
        
        sinopsisPeliculaLabel.anchor(top: tituloPeliculaLabel.bottomAnchor, leading: tituloPeliculaLabel.leadingAnchor, bottom: imagenPeliculaView.bottomAnchor, trailing: tituloPeliculaLabel.trailingAnchor)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
