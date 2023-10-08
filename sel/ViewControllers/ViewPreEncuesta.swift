//
//  ViewPreEncuesta.swift
//  sel
//
//  Created by Fernando García on 14/09/23.
//

import UIKit

class ViewPreEncuesta: UIViewController {

    @IBOutlet weak var buttonIngresar: UIButton!
    
    @IBOutlet weak var labelUsuario: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estiloBotones()
        // Do any additional setup after loading the view.
    }
    
    func estiloBotones(){
        buttonIngresar.tintColor = UIColor(named: "azulTec")
        buttonIngresar.layer.cornerRadius = 25
        buttonIngresar.clipsToBounds = true
    }


}
