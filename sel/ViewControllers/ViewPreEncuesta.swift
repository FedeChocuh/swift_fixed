//
//  ViewPreEncuesta.swift
//  sel
//
//  Created by Fernando García on 14/09/23.
//

import UIKit

class ViewPreEncuesta: UIViewController {
    
    @IBOutlet weak var labelUser: UILabel!
    
    @IBOutlet weak var buttonEnter: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estiloBotones()
        accessDefaults()
        
    }
    // Do any additional setup after loading the view.
    
    func estiloBotones(){
        buttonEnter.tintColor = UIColor(named: "azulTec")
        buttonEnter.layer.cornerRadius = 25
        buttonEnter.clipsToBounds = true
    }
    
    func accessDefaults() {
        // Assuming you are in another script or class
        let defaults = UserDefaults.standard

        if let name = defaults.string(forKey: "name") {
            // Use the retrieved "name" value here
            labelUser.text = name
        } else {
            // Handle the case where the "name" value is not found
            print("Name value not found in UserDefaults")
        }
    }
    
}


