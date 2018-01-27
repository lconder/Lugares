//
//  AddPlaceViewController.swift
//  Lugares del Mundo
//
//  Created by Luis Conde on 24/01/18.
//  Copyright © 2018 Luis Conde. All rights reserved.
//

import UIKit
import CoreData

class AddPlaceViewController: UITableViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var textFieldName: UITextField!
    
    @IBOutlet var textFieldType: UITextField!
    
    @IBOutlet var textFieldAddress: UITextField!
    
    @IBOutlet var textFieldPhone: UITextField!
    
    @IBOutlet var textFieldWebsite: UITextField!
    
    @IBOutlet var buttonDontLike: UIButton!
    
    @IBOutlet var buttonLike: UIButton!
    
    @IBOutlet var buttonLove: UIButton!
    
    var place: Place!
    
    
    
    var rating: String?
    let selectedColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    let defaultColor = UIColor(red: 176/255, green: 178/255, blue: 178/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textFieldName.delegate = self
        self.textFieldType.delegate = self
        self.textFieldPhone.delegate = self
        self.textFieldAddress.delegate = self
        self.textFieldWebsite.delegate = self
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Actions
    
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        
        if let name = self.textFieldName.text,
        let type = self.textFieldType.text,
        let address = self.textFieldAddress.text,
        let phone = self.textFieldPhone.text,
        let website = self.textFieldWebsite.text,
        let theImage = self.imageView.image,
        let rating = self.rating {
            
            if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
                
                let context = container.viewContext
                self.place = NSEntityDescription.insertNewObject(forEntityName: "Place", into: context) as! Place
                
                self.place.name = name
                self.place.type = type
                self.place.location = address
                self.place.phone = phone
                self.place.website = website
                self.place.rating = rating
                self.place.image = UIImagePNGRepresentation(theImage)! as NSData
                
                do {
                    try context.save()
                } catch {
                    print("Ha habido un error al guardar en Core Data")
                }
            }
            self.performSegue(withIdentifier: "unwindToMainViewController", sender: self)
        }else{
            print("Verifica que los campos esten llenos")
        }
        
    }
    
    
  

    @IBAction func ratingPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            self.rating = "dislike"
            self.buttonDontLike.backgroundColor = self.selectedColor
            self.buttonLike.backgroundColor = self.defaultColor
            self.buttonLove.backgroundColor = self.defaultColor
        case 1:
            self.rating = "good"
            self.buttonDontLike.backgroundColor = self.defaultColor
            self.buttonLike.backgroundColor = self.selectedColor
            self.buttonLove.backgroundColor = self.defaultColor
        case 2:
            self.rating = "great"
            self.buttonDontLike.backgroundColor = self.defaultColor
            self.buttonLike.backgroundColor = self.defaultColor
            self.buttonLove.backgroundColor = self.selectedColor
        default:
            break
        }
        
    }
    
    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row==0 {
        
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true, completion: nil)
                
            }
        
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    

}
