//
//  ViewController.swift
//  sel
//
//  Created by Fernando García on 31/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var buttonIngresar: UIButton!
    
    
    @IBOutlet weak var buttonRegistrarse: UIButton!    
    
    @IBOutlet weak var layerNombreUsuario: UITextField!
    
    @IBOutlet weak var layerPassword: UITextField!
    
    private var loginVM = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        estiloBotones()
        // Do any additional setup after loading the view.
        
    }
    
    func estiloBotones(){
        buttonIngresar.tintColor = UIColor(named: "azulTec")
        buttonIngresar.layer.cornerRadius = 25
        buttonIngresar.clipsToBounds = true
        
        buttonRegistrarse.tintColor = UIColor(named: "azulFuerte")
        buttonRegistrarse.layer.cornerRadius = 25
        buttonRegistrarse.clipsToBounds = true
        
        layerNombreUsuario.layer.cornerRadius = 25
        layerNombreUsuario.layer.borderWidth = 1
        layerNombreUsuario.layer.borderColor = UIColor.black.cgColor
        
        layerPassword.layer.cornerRadius = 25
        layerPassword.layer.borderWidth = 1
        layerPassword.layer.borderColor = UIColor.black.cgColor
        
    }
    
    @IBAction func Access(_ sender: UIButton) {
        
        if let enteredNombreUsuario = layerNombreUsuario.text,
           let enteredPassword = layerPassword.text,
           enteredNombreUsuario == loginVM.name && enteredPassword == loginVM.password {
            loginVM.Login()
            performSegue(withIdentifier: "IngresarToPreEncuesta", sender: self)
        
        }
            
        
    }
    
    
    
        
        
        
}

