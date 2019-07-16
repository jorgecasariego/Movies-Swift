//
//  SpacerView.swift
//  PeliculasWithMenu
//
//  Created by Jorge Casariego on 7/15/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

class SpacerView: UIView {
    
    let space: CGFloat

    override var intrinsicContentSize: CGSize {
        return .init(width: space, height: space)
    }
    
    init(space: CGFloat) {
        self.space = space
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
