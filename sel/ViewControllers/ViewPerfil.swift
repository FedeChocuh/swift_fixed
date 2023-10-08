//
//  ViewPerfil.swift
//  sel
//
//  Created by Fernando García on 01/10/23.
//

import UIKit

class ViewPerfil: UIViewController {

    
    @IBOutlet weak var formaView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estiloBotones()
        formaView.backgroundColor = UIColor(named:"azulTec")
        
        
    }
    
    func estiloBotones(){
        formaView.layer.cornerRadius = 15
    }


}
