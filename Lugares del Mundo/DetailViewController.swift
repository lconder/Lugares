//
//  DetailViewController.swift
//  Recetario
//
//  Created by Luis Conde on 13/01/18.
//  Copyright © 2018 Luis Conde. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var recipeImageView: UIImageView!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var ratingButton: UIButton!
    
    
    var place: Place!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.recipeImageView.image = place.image
        
        let image = UIImage(named: self.place.rating)
        self.ratingButton.setImage(image, for: .normal)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
    
        if let reviewC = segue.source as? ReviewViewController{
        
            if let rating = reviewC.ratingSelected {
            
                self.place.rating = rating
                let image = UIImage(named: self.place.rating)
                self.ratingButton.setImage(image, for: .normal)
                
            }
        
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowMap" {
            
            let destinationViewController = segue.destination as! MapViewController
            
            destinationViewController.place = self.place
            
        }
        
        
    }
    

}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRecipeCell" , for: indexPath) as! RecipeDetailViewCell
        
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Nombre:"
            cell.valueLabel.text = self.place.name
        case 1:
            cell.keyLabel.text = "Tipo:"
            cell.valueLabel.text = self.place.type
        case 2:
            cell.keyLabel.text = "Ubicación:"
            cell.valueLabel.text = self.place.location
        case 3:
            cell.keyLabel.text = "Teléfono:"
            cell.valueLabel.text = self.place.phone
        case 4:
            cell.keyLabel.text = "Website:"
            cell.valueLabel.text = self.place.website
        default:
            break
        }
        
        return cell
    }
    
    
    
}


extension DetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 2:
            print("Hemos seleccionado la geolocalización")
            self.performSegue(withIdentifier: "ShowMap", sender: self)
            break
        default:
            break
        }
        
    }
    
}
