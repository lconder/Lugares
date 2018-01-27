//
//  ViewController.swift
//  Recetario
//
//  Created by Luis Conde on 13/01/18.
//  Copyright © 2018 Luis Conde. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var places: [Place] = []
    
    var fetchResultsController: NSFetchedResultsController<Place>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<Place> = NSFetchRequest(entityName: "Place")
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
        
            let context = container.viewContext
            
            self.fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            
            self.fetchResultsController.delegate = self
            
            do {
                try fetchResultsController.performFetch()
                self.places = fetchResultsController.fetchedObjects!
            }catch{
                print("Error al obtener los lugares desde la BD")
            }
            
        
        }
        

        
        /*var place = Place(name: "Coliseo de Roma", type: "Estructura", location: "Piazza del Colosseo, 1, 00184 Roma RM, Italia", image: #imageLiteral(resourceName: "coliseo"), phone: "+39 06 3996 7700", website: "http://www.soprintendenzaspecialeroma.it/categorie/la-soprintendenza-speciale-per-il-colosseo-e-l-area-archeologica-centrale-di-roma_6/&set=0&l=2&p=6")
        places.append(place)
        
        place = Place(name: "Chichen Itza", type: "Estructura", location: "Chichen Itza", image: #imageLiteral(resourceName: "chichen"), phone: "01 985 851 0137", website: "www.inah.gob.mx")
        places.append(place)
        
        place = Place(name: "Cristo Redentor", type: "Monumento", location: "Parque Nacional da Tijuca - Alto da Boa Vista, Rio de Janeiro - RJ, Brasil", image: #imageLiteral(resourceName: "cristo"), phone: "", website: "www.cristoredentoroficial.com.br")
        places.append(place)
        
        place = Place(name: "Machu Picchu", type: "Estructura", location: "Perú", image: #imageLiteral(resourceName: "machu"), phone: "+51 84 582030", website: "www.machupicchu.gob.pe")
        places.append(place)
        
        place = Place(name: "Muralla China", type: "Estructura", location: "Huairou, China", image: #imageLiteral(resourceName: "muralla"), phone: "", website: "https://en.wikipedia.org/wiki/Great_Wall_of_China")
        places.append(place)
        
        place = Place(name: "Petra", type: "Estructura", location: "Jordania", image: #imageLiteral(resourceName: "petra"), phone: "+962 3 215 6060", website: "www.visitpetra.jo")
        places.append(place)
        
        place = Place(name: "Taj Mahal", type: "Estructura", location: "Dharmapuri, Forest Colony, Tajganj, Agra, Uttar Pradesh 282001, India", image: #imageLiteral(resourceName: "taj"), phone: "", website: "www.tajmahal.gov.in")
        places.append(place)*/
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //Nos indica el número de secciones de la tabla
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return places.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "RecipeCell"
        let place = places[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RecipeCell
        
        cell.thumbnailImageView.image = UIImage(data: place.image as Data)
        cell.nameLabel.text = place.name
        cell.timeLabel.text = place.type
        cell.ingredientsLabel.text = place.location
        
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //compartir
        let shareAction = UITableViewRowAction(style: .normal, title: "Compartir") { (action, indexPath) in
            
            let shareDefaultText = "Estoy mirando el lugar: \(self.places[indexPath.row].name), en la app Lugares del Mundo"
            
            let activityController = UIActivityViewController(activityItems: [shareDefaultText, self.places[indexPath.row].image], applicationActivities: nil)
            
            self.present(activityController, animated: true, completion: nil)
            
            
        }
        
        //borrar
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Borrar") { (action, indexPath) in
            
            if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
                
                let context = container.viewContext
                
                let placeToDelete = self.fetchResultsController.object(at: indexPath)
                
                context.delete(placeToDelete)
                
                do {
                    try context.save()
                }catch{
                    print("Error intentando borrar un lugar")
                }
                
            }
            
        }
        
        shareAction.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        return [shareAction, deleteAction]
        
    }
    
    
    
    //MARK: - UITableViewDelegate
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="showRecipeDetail" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let selectedRecipe = self.places[indexPath.row]
                let destinationViewController = segue.destination as! DetailViewController
                destinationViewController.place = selectedRecipe
            }
        }
        
    }
    
    
    @IBAction func unwindToMainViewController(segue: UIStoryboardSegue) {
    
        if segue.identifier == "unwindToMainViewController" {
        
            if let addPlaceVC = segue.source as? AddPlaceViewController {
                
                if let newPlace = addPlaceVC.place {
                    self.places.append(newPlace)
                }
            
            }
            
        }
        
    
    }
    

    
}


extension ViewController: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                self.tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        case .update:
            if let indexPath = indexPath {
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                self.tableView.moveRow(at: indexPath, to: newIndexPath)
            }
        }
        
        self.places = controller.fetchedObjects as! [Place]
        
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    

}








