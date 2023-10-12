//
//  ActividadesMain.swift
//  sel
//
//  Created by Fernando García on 08/10/23.
//

import UIKit




class ActividadesMain: UIViewController {
    
    
    @IBOutlet weak var viewAct1: UIView!
    @IBOutlet weak var buttonAct1: UIButton!
        
    @IBOutlet weak var viewAct2: UIView!
    @IBOutlet weak var buttonAct2: UIButton!
    
    @IBOutlet weak var viewAct3: UIView!
    @IBOutlet weak var buttonAct3: UIButton!
    
    @IBOutlet weak var viewAct4: UIView!
    @IBOutlet weak var buttonAct4: UIButton!
    
    @IBOutlet weak var viewFinal: UIView!
    @IBOutlet weak var buttonFinal: UIButton!
    
    @IBOutlet weak var ViewCierre: UIView!
    @IBOutlet weak var buttonCierre: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estiloBotones()
        self.navigationItem.hidesBackButton = true

    }
    
    func estiloBotones() {
        viewAct1.layer.cornerRadius = 15
        viewAct2.layer.cornerRadius = 15
        viewAct3.layer.cornerRadius = 15
        viewAct4.layer.cornerRadius = 15
        viewFinal.layer.cornerRadius = 15
        ViewCierre.layer.cornerRadius = 15
        
        buttonAct1.tintColor = UIColor(named: "azulTec")
        buttonAct1.layer.cornerRadius = 25
        buttonAct1.clipsToBounds = true
        
        buttonAct2.tintColor = UIColor(named: "azulTec")
        buttonAct2.layer.cornerRadius = 25
        buttonAct2.clipsToBounds = true
        
        buttonAct3.tintColor = UIColor(named: "azulTec")
        buttonAct3.layer.cornerRadius = 25
        buttonAct3.clipsToBounds = true
        
        buttonAct4.tintColor = UIColor(named: "azulTec")
        buttonAct4.layer.cornerRadius = 25
        buttonAct4.clipsToBounds = true
        
        buttonCierre.tintColor = UIColor(named: "azulTec")
        buttonCierre.layer.cornerRadius = 25
        buttonCierre.clipsToBounds = true
        
        buttonFinal.tintColor = UIColor(named: "azulTec")
        buttonFinal.layer.cornerRadius = 25
        buttonFinal.clipsToBounds = true

    }
    
    


}
