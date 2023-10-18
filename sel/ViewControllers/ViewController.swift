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
        guard let email = layerNombreUsuario.text, let password = layerPassword.text else {
            return
        }
        let webservice = Webservice()
        // Call the login method from your WebService
        webservice.login(email: email, password: password) { result in
            let defaults = UserDefaults.standard
            let done = defaults.integer(forKey: "quiz_done")
            DispatchQueue.main.async {
                if done == 1 {
                    self.performSegue(withIdentifier: "QuizDone", sender: self)
                    print("QuizDone Segue performed.")
                } else {
                    if case .success(let token) = result {
                        // Perform a segue to the next view controller or any other action
                        self.performSegue(withIdentifier: "IngresarToPreEncuesta", sender: self)
                        print("Login successful. Token: \(token)")
                    } else if case .failure(let error) = result {
                        // Handle the error without using an errorLabel
                        self.handleLoginError(error)
                    }
                }
                print(done)
            }
            
        }
        
        
        
        /*switch result {
         case .success(let token):
         // Perform a segue to the next view controller or any other action
         self.performSegue(withIdentifier: "IngresarToPreEncuesta", sender: self)
         print("Login successful. Token: \(token)")
         case .failure(let error):
         // Handle the error without using an errorLabel
         self.handleLoginError(error)
         }*/
        
    }
    
    
    
    /*@IBAction func QuizDone(_ sender: Any) {
     let defaults = UserDefaults.standard
     let done = defaults.integer(forKey: "quiz_done")
     if done == 1 {
     self.performSegue(withIdentifier: "QuizzDone", sender: self)
     print(done)
     }
     print(done)
     } */
    
    func handleLoginError(_ error: AuthenticationError) {
        switch error {
        case .custom(let errorMessage):
            // Handle custom error message
            print("Custom error: \(errorMessage)")
        case .invalidCredentials:
            // Handle invalid credentials error
            print("Invalid email or password")
            // You can display an alert or perform other actions here
            // Example: self.presentErrorAlert(message: "Invalid email or password")
            // Handle other error cases as needed
        }
    }
    
    
    
    
    
}


