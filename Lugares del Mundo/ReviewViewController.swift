//
//  ReviewViewController.swift
//  Recetario
//
//  Created by Luis Conde on 16/01/18.
//  Copyright © 2018 Luis Conde. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    
    var ratingSelected: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        styleImageView()
    }
    
    func styleImageView(){
        
        let blurEffect = UIBlurEffect(style: .regular)
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = view.bounds
        
        self.backgroundImageView.addSubview(blurEffectView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func ratingPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            ratingSelected = "dislike"
            self.showAlert(type: 1)
        case 2:
            ratingSelected = "good"
            self.showAlert(type: 2)
        case 3:
            ratingSelected = "great"
            self.showAlert(type: 3)
        default:
            break
        }
        
    }
    
    func showAlert(type: Int){
        
        var title = ""
        switch type {
        case 1:
            title="No me gusta"
        case 2:
            title="Me gusta"
        case 3:
            title="Me encanta"
        default:
            break
        }
        
        
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    

}
