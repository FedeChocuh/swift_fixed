//
//  resultEncuentFinal.swift
//  sel
//
//  Created by Julia🌺 Cascelli🌊 on 11/10/23.
//

import UIKit

class resultEncuestFinal: UIViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var viewPasionyCompromiso: UIView!
    
    @IBOutlet weak var viewHabilidades: UIView!
    
    @IBOutlet weak var viewPensamiento: UIView!
    
    @IBOutlet weak var viewInvestigacion: UITextView!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    
    
    @IBOutlet weak var label4: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estiloBotones()
        calculatePercentage()
        
        // Do any additional setup after loading the view.
    }
    
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

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
