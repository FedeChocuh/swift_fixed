//
//  resultFinal.swift
//  sel
//
//  Created by Julia🌺 Cascelli🌊 on 16/10/23.
//

import UIKit

class resultFinal: UIViewController {
    
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var viewPasionyCompromiso: UIView!
    
    @IBOutlet weak var viewHabilidades: UIView!
    
    
    @IBOutlet weak var viewPensamiento: UIView!
    
    @IBOutlet weak var viewInvestigacion: UIView!
    
    @IBOutlet weak var buttonContinue: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var label4: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estiloBotones()
        calculatePercentage()
        
        

}
    
    func switchToTabBarController() {
        // Ensure this code is run on the main thread
        DispatchQueue.main.async {
            // Get a reference to the storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)  // Replace "Main" with the name of your storyboard
            
            // Instantiate the tab bar controller using its storyboard ID
            guard let tabBarController = storyboard.instantiateViewController(identifier: "TabBarController") as? UITabBarController else {
                print("Could not instantiate TabBarController")
                return
            }
            
            // Set the tab bar controller as the root view controller
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = tabBarController
            }
        }
    }
    // Do any additional setup after loading the view.
    
    func estiloBotones(){
        viewPasionyCompromiso.layer.cornerRadius = 15
        viewHabilidades.layer.cornerRadius = 15
        viewPensamiento.layer.cornerRadius = 15
        viewInvestigacion.layer.cornerRadius = 15
        
        buttonContinue.tintColor = UIColor(named: "azulFuerte")
        buttonContinue.layer.cornerRadius = 25
        buttonContinue.clipsToBounds = true
        
        
    }
    
    func calculatePercentage(){
        
        let answersPasionYcompromiso = defaults.integer(forKey: "answers")
        let answersHabilidades = defaults.integer(forKey: "answers")
        let answersPensamiento = defaults.integer(forKey: "answers")
        let answersInvestigacion = defaults.integer(forKey: "answers")
        
        if answersPasionYcompromiso <= 12 {
            let percentage = (answersPasionYcompromiso) / 12 * 100
            self.label1.text = String(percentage)
        }
        if answersHabilidades >= 13 && answersHabilidades <= 24 {
            let percentage = (answersHabilidades) / 12 * 100
            self.label2.text = String(percentage)
        }
        if answersPensamiento >= 25 && answersPensamiento <= 41 {
            let percentage = (answersPensamiento) / 17 * 100
            self.label3.text = String(percentage)
        }
        if answersInvestigacion >= 42 && answersInvestigacion <= 50 {
            let percentage = (answersInvestigacion) / 9 * 100
            self.label4.text = String(percentage)
        }
        
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        switchToTabBarController()

    }
    
    
        }
