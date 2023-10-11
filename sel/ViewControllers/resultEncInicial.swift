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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estiloBotones()
        calculatePercentage()
        
        
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
        
        let answers = defaults.integer(forKey: "answers")
        
        if answers <= 12 {
            let percentage = (answers) / 12 * 100
            self.label1.text = String(percentage)
        } else if answers >= 13 && answers <= 24 {
            let percentage = (answers) / 12 * 100
            self.label2.text = String(percentage)
        } else if answers >= 25 && answers <= 41 {
            let percentage = (answers) / 17 * 100
            self.label3.text = String(percentage)
        } else if answers >= 42 && answers <= 50 {
            let percentage = (answers) / 9 * 100
            self.label4.text = String(percentage)
        }
        
        
        
        
    }
}
