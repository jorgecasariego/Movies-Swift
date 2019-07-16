//
//  BaseSlidingController.swift
//  PeliculasWithMenu
//
//  Created by Jorge Casariego on 7/15/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

class RightContainerView: UIView {}
class MenuContainerView: UIView {}
class DarkContainerView: UIView {}

class BaseSlidingController: UIViewController {
    
    let redView: RightContainerView = {
        let v = RightContainerView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let greenView: MenuContainerView = {
        let v = MenuContainerView()
        v.backgroundColor = .green
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let darkCoverView: DarkContainerView = {
        let v = DarkContainerView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        
        // Tarea 1: Cerrar menu al hacer clik en el controlador de afuera
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss))
        darkCoverView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapDismiss() {
        handleHide()
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        // Magico
        x = isMenuOpen ? x + menuWidth : x
        // Solo puede ir hasta el ancho del menu
        x = min(menuWidth, x)
        // solo puede ir hasta la posicion 0 y no mas a la izquierda que eso
        x = max(0, x)
        
        redViewLeadingConstraint.constant = x
        // Tarea 2: El lado derecho del redView tambien movemos al mismo tiempo que movemos el menu
        redViewTrailingConstraint.constant = x
        darkCoverView.alpha = x / menuWidth
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    fileprivate let velocityOpenThreshold: CGFloat = 500
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        print(translation.x)
        
        if isMenuOpen {
            if abs(velocity.x) > velocityOpenThreshold {
                handleHide()
                return
            }
            
            if abs(translation.x) < menuWidth / 2 {
                handleOpen()
            } else {
                handleHide()
            }
            
        } else {
            if velocity.x > velocityOpenThreshold {
                handleOpen()
                return
            }
            
            //Dependiendo de donde suelte el gesto va a abrir o cerrar el menu
            if translation.x < menuWidth / 2 {
                handleHide()
            } else {
                handleOpen()
            }
        }
        
        if translation.x < menuWidth / 2 {
            redViewLeadingConstraint.constant = 0
            isMenuOpen = false
        } else {
            redViewLeadingConstraint.constant = menuWidth
            isMenuOpen = true
        }
        
        // Usando layoutIfNeeded lo que hacemos es animar si es que se utiliza algun constraint. Y lo que hacemos arriba de este comentario es utilizando unos constraints para abrir o cerrar el Menu
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            // Tambien es magico el funcionamiento de esto
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func handleOpen() {
        isMenuOpen = true
        redViewLeadingConstraint.constant = menuWidth
        redViewTrailingConstraint.constant = menuWidth
        
        performAnimation(transform: CGAffineTransform(translationX: self.menuWidth, y: 0))
    }
    
    @objc func handleHide() {
        redViewLeadingConstraint.constant = 0
        redViewTrailingConstraint.constant = 0
        
        isMenuOpen = false
        performAnimation(transform: .identity)
    }
    
    func didSelectMenuItem(indexPath: IndexPath) {
        // antes de cargar el nuevo controlador limpiamos el cargado anteriormente
        performRightViewCleanUp()
        // Movemos aquí ya que hay un efecto raro al abrir los controladores
        handleHide()
        
        switch indexPath.row {
        case 0:
            rightViewController = UINavigationController(rootViewController: HomeController())
        case 1:
            rightViewController = UINavigationController(rootViewController: ListaController())
        case 2:
            rightViewController = FavoritosController()
        default:
            let tabBarController = UITabBarController()
            let navController = UINavigationController(rootViewController: MomentoController())
            navController.tabBarItem.title = "Momentos"
            navController.tabBarItem.image = #imageLiteral(resourceName: "moments")
            tabBarController.viewControllers = [navController]
            rightViewController = tabBarController
        }
        
        redView.addSubview(rightViewController.view)
        addChild(rightViewController)
        
        // Con esta linea hacemos que el darkView se muestre al abrir el menu y desaparezca al cerrar el menu
        // Porque? Ya que al hacer click sobre un item del menu estamos agregando una vista encima del carkCoverView. Así que lo que hacemos aquí es poner de vuelta el darkView encima de la nueva vista 
        redView.bringSubviewToFront(darkCoverView)
    }
    
    // 1. Cada vez que hacemos click sobre un item guardaremos en esta variable el controlador que se añade
    // 2. Ahora lo que vamos a hacer es inicializar rl rightViewController con HomeController pero dentro de un NavBar
    var rightViewController: UIViewController = UINavigationController(rootViewController: HomeController())
    
    fileprivate func performRightViewCleanUp() {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }
    
    fileprivate func performAnimation(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpen ? 1 : 0
            
        }, completion: nil)
    }
    
    var redViewLeadingConstraint: NSLayoutConstraint!
    var redViewTrailingConstraint: NSLayoutConstraint!
    
    let menuWidth: CGFloat = 300
    var isMenuOpen = false
    
    fileprivate func setupViews() {
        view.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(darkCoverView)
        
        // Usando Auto Layout
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            greenView.topAnchor.constraint(equalTo: view.topAnchor),
            greenView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            greenView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            greenView.widthAnchor.constraint(equalToConstant: menuWidth),
            
            darkCoverView.topAnchor.constraint(equalTo: redView.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            ])
        
        redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redViewLeadingConstraint.isActive = true
        
        // Tarea 2: Asi como manejamos con el lado izquierdo(leadingAnchor) del redView, debemos hacer lo mismo con el lado derecho (trailingAnchor)
        redViewTrailingConstraint = redView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        redViewTrailingConstraint.isActive = true
        
        
        setupViewController()
    }
    
    fileprivate func setupViewController() {
        // Añadimos HomeController
        //let homeController = HomeController()
        
        // Inicialmente nuestro controlador es HomeController
        //rightViewController = HomeController()
        let menuController = MenuController()
        
        let homeView = rightViewController.view!
        let menuView = menuController.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(homeView)
        greenView.addSubview(menuView)
        
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: redView.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            
            menuView.topAnchor.constraint(equalTo: greenView.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: greenView.leadingAnchor),
            menuView.bottomAnchor.constraint(equalTo: greenView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: greenView.trailingAnchor),
            
            ])
        
        addChild(rightViewController)
        addChild(menuController)
    }
}
