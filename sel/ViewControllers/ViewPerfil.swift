//
//  ViewPerfil.swift
//  sel
//
//  Created by Fernando García on 01/10/23.
//

import UIKit

class ViewPerfil: UIViewController {
    
    var loginVM = RegisterViewModel()

    
    @IBOutlet var viewMain: UIView!
    
    @IBOutlet weak var formaView: UIView!
    
    @IBOutlet weak var labelNombre: UITextField!
    
    @IBOutlet weak var labelMail: UITextField!
    
    @IBOutlet weak var labelPass: UITextField!
    
    @IBOutlet weak var labelNewPass: UITextField!
    
    @IBOutlet weak var buttonLogout: UIButton!            //Utilizo una IBAction
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        //Aqui tenemos q borrar las variables donde almacenamos los datos (nombre previsto de la variable defaults)
        UserDefaults.standard.removeObject(forKey: "jsonwebtoken")
        
        // Navega de regreso a la pantalla de inicio de sesión (puedes ajustar esto según tu diseño de navegación).
        if let loginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginVC") {
            navigationController?.pushViewController(loginViewController, animated: true)
        }
        
    }
    
    @IBOutlet weak var buttonModify: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estiloBotones()
        viewMain.backgroundColor = UIColor(named:"azulTec")
        
        
    }
    
    func estiloBotones(){
        formaView.layer.cornerRadius = 15
        
        buttonLogout.tintColor = UIColor(named: "azulTec")
        buttonLogout.layer.cornerRadius = 25
        buttonLogout.clipsToBounds = true
        
        buttonModify.tintColor = UIColor(named: "azulTec")
        buttonModify.layer.cornerRadius = 25
        buttonModify.clipsToBounds = true
        
        labelNombre.layer.cornerRadius = 25
        labelNombre.layer.borderWidth = 1
        labelNombre.layer.borderColor = UIColor.black.cgColor
        labelNombre.tintColor = UIColor(named: "labelPerfil")
        
        labelMail.layer.cornerRadius = 25
        labelMail.layer.borderWidth = 1
        labelMail.layer.borderColor = UIColor.black.cgColor
        labelMail.tintColor = UIColor(named: "labelPerfil")
        
        labelPass.layer.cornerRadius = 25
        labelPass.layer.borderWidth = 1
        labelPass.layer.borderColor = UIColor.black.cgColor
        labelPass.tintColor = UIColor(named: "labelPerfil")
        
        labelNewPass.layer.cornerRadius = 25
        labelNewPass.layer.borderWidth = 1
        labelNewPass.layer.borderColor = UIColor.black.cgColor
        labelNewPass.tintColor = UIColor(named: "labelPerfil")
        
    }
    
func showLabelData() {
    if let storedUsername = UserDefaults.standard.string(forKey: "UsernameKey") {
        labelNombre.text = storedUsername
    }
    labelPass.text = loginVM.password
}



}
