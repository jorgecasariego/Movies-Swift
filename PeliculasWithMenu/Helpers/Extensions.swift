//
//  Extensions.swift
//  PeliculasWithMenu
//
//  Created by Jorge Casariego on 7/16/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

extension UserDefaults {
    enum UserDefaultsKeys: String {
        case esUsuarioValido
    }
    
    func setEsUsuarioValido(value: Bool) {
        set(value, forKey: UserDefaultsKeys.esUsuarioValido.rawValue)
        synchronize()
    }
    
    func esUsuarioValido() -> Bool {
        return bool(forKey: UserDefaultsKeys.esUsuarioValido.rawValue)
    }
}
