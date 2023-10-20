//
//  resultEncInicial.swift
//  sel
//
//  Created by Fernando García on 10/10/23.
//

import Foundation

import UIKit

class resultEncInicial: UIViewController {
    
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
    var answers1to12: [Answer] = []
    var answers13to24: [Answer] = []
    var answers25to41: [Answer] = []
    var answers42to50: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estiloBotones()
        calculatePercentage()
        
        
    }
    func switchToTabBarController() {
        // Ensure this code is run on the main thread
        DispatchQueue.main.async {
            // Get a reference to the storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
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
        buttonContinue.layer.cornerRadius = 15
        buttonContinue.clipsToBounds = true
        
        
    }
    
    func calculatePercentage(){
        label1.text = "\(calculatePercentageForAnswers(answers: answers1to12, outOf: 12))%"
        label2.text = "\(calculatePercentageForAnswers(answers: answers13to24, outOf: 12))%"
        label3.text = "\(calculatePercentageForAnswers(answers: answers25to41, outOf: 17))%"
        label4.text = "\(calculatePercentageForAnswers(answers: answers42to50, outOf: 9))%"
    }
    
    func calculatePercentageForAnswers(answers: [Answer], outOf totalQuestions: Int) -> Int {
        let totalScore = answers.reduce(0) { $0 + $1.answer }
        let maximumScore = totalQuestions * 5
        return (totalScore * 100) / maximumScore
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switchToTabBarController()
        calculatePercentage()
    }
}
