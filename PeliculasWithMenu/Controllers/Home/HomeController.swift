//
//  ViewController.swift
//  PeliculasWithMenu
//
//  Created by Jorge Casariego on 7/8/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

class HomeController: UITableViewController, UIGestureRecognizerDelegate {
    
    let cellId = "cellId"
    let peliculas: [MovieItem] = [
        MovieItem(nombrePelicula: "Toy Story", sipnosisPelicula: "En esta ocasión, el popular Woody aparece como el guardián de Forky, un juguete creado por Bonnie, su nueva dueña tras ser cedida como un noble gesto por el adolescente Andy en la última cinta.", imagePelicula: "pelicula1", estrenoPelicula: "2019-10-08"),
        
        MovieItem(nombrePelicula: "Aladdin", sipnosisPelicula: "Rodeada por los Siete Desiertos, se encuentra la ciudad de Agrabah, una metrópoli de calles estrechas y plagadas de gente, donde en lo más alto puede verse el majestuoso castillo del Sultán. Allí vive la joven princesa Jasmine junto con su padre el Sultán y el visir real Jafar. La vida de todos ellos dará un giro inesperado después de que el joven Aladdin entre en la Cueva de las Maravillas y descubra la lámpara mágica cuyo Genio tiene el poder omnipotente de conceder tres deseos a cualquiera que la posea", imagePelicula: "pelicula2", estrenoPelicula: "2019-10-08"),
        
        MovieItem(nombrePelicula: "¡Shazam!", sipnosisPelicula: "El cine de superhéroes funciona tan bien en taquilla, y está tan explotado, que si esto sigue así en poco tiempo no habrá un solo personaje de Marvel o DC que no tenga su película propia. En esta ocasión el agraciado es Shazam, personaje de DC Comics que fue nombrado en sus inicios paradójicamente como Capitán Marvel. ", imagePelicula: "pelicula3", estrenoPelicula: "2019-10-08"),
        
        MovieItem(nombrePelicula: "Dumbo", sipnosisPelicula: "Muchos nos sorprendimos cuando supimos que se haría un remake del clásico infantil 'Dumbo' y además, que éste sería dirigido por Tim Burton. ", imagePelicula: "pelicula4", estrenoPelicula: "2019-10-08")
    ]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if UserDefaults.standard.esUsuarioValido() {
//            print("Es usuario valido")
//        } else {
//            let loginController = LoginController()
//            UIApplication.shared.keyWindow?.rootViewController?.present(loginController, animated: false, completion: nil)
//        }
    }
    
   override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
    
    
        setupNavigationsItems()
    
        // 1. El primer paso es registrar nuestra celda
        tableView.register(MoviewCell.self, forCellReuseIdentifier: cellId)
    }
  
    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.handleOpen()
    }
    
    fileprivate func setupNavigationsItems() {
        navigationItem.title = "Peliculas"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peliculas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 2. Usar nuestra celda
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MoviewCell
        
        let pelicula = peliculas[indexPath.row]
        
        cell.tituloPeliculaLabel.text = pelicula.nombrePelicula
        cell.sinopsisPeliculaLabel.text = pelicula.sipnosisPelicula
        cell.imagenPeliculaView.image = UIImage(named: pelicula.imagePelicula)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detallePelicula = DetallePeliculaController()
        detallePelicula.label.text = peliculas[indexPath.row].nombrePelicula
        navigationController?.pushViewController(detallePelicula, animated: true)
    }

}

