//
//  ViewCuestInicial.swift
//  sel
//
//  Created by Fernando García on 26/09/23.
//

import UIKit

class ViewCuestInicial: UIViewController {

    @IBOutlet weak var labelTipoPregunta: UILabel!
    
    @IBOutlet weak var labelNumPregunta: UILabel!
    
    @IBOutlet weak var labelPregunta: UILabel!
    
    @IBOutlet weak var buttonTotalmenteDesacuerdo: UIButton!
    
    @IBOutlet weak var buttonDesacuerdo: UIButton!
    
    @IBOutlet weak var buttonNiAcuerdoNiDesacuerdo: UIButton!
    
    @IBOutlet weak var buttonAcuerdo: UIButton!
    
    @IBOutlet weak var buttonTotalmenteAcuerdo: UIButton!
    
    @IBOutlet weak var barraProgreso: UIProgressView!
    
    var engine=EcomplexityEngine()
    var userResponses = UserResponses()
    var userResponsesController = UserResponsesController()


     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estiloBotones()
        
        Task{
            do{
                let questions = try await Question.fetchQuestions()
                updateUI(with: questions)
            }catch{
                displayError(QuestionError.itemNotFound, title: "No se pudo accer a las preguntas")
            }
        }
    }
    
    
    func estiloBotones(){
        
        buttonTotalmenteDesacuerdo.tintColor = UIColor.white
        buttonTotalmenteDesacuerdo.layer.cornerRadius = 25
        buttonTotalmenteDesacuerdo.clipsToBounds = true
        buttonTotalmenteDesacuerdo.layer.borderWidth = 1
        buttonTotalmenteDesacuerdo.layer.borderColor = UIColor.black.cgColor
        
        buttonDesacuerdo.tintColor = UIColor.white
        buttonDesacuerdo.layer.cornerRadius = 25
        buttonDesacuerdo.clipsToBounds = true
        buttonDesacuerdo.layer.borderWidth = 1
        buttonDesacuerdo.layer.borderColor = UIColor.black.cgColor
        
        buttonNiAcuerdoNiDesacuerdo.tintColor = UIColor.white
        buttonNiAcuerdoNiDesacuerdo.layer.cornerRadius = 25
        buttonNiAcuerdoNiDesacuerdo.clipsToBounds = true
        buttonNiAcuerdoNiDesacuerdo.layer.borderWidth = 1
        buttonNiAcuerdoNiDesacuerdo.layer.borderColor = UIColor.black.cgColor
        
        buttonAcuerdo.tintColor = UIColor.white
        buttonAcuerdo.layer.cornerRadius = 25
        buttonAcuerdo.clipsToBounds = true
        buttonAcuerdo.layer.borderWidth = 1
        buttonAcuerdo.layer.borderColor = UIColor.black.cgColor
        
        buttonTotalmenteAcuerdo.tintColor = UIColor.white
        buttonTotalmenteAcuerdo.layer.cornerRadius = 25
        buttonTotalmenteAcuerdo.clipsToBounds = true
        buttonTotalmenteAcuerdo.layer.borderWidth = 1
        buttonTotalmenteAcuerdo.layer.borderColor = UIColor.black.cgColor
        labelTipoPregunta.isEnabled = false
        

    }
    
    func updateUI(with questions:Questions){
        DispatchQueue.main.async {
            self.engine.initialize(q: questions)
            self.barraProgreso.progress = self.engine.getProgress()
            self.labelPregunta.text = self.engine.getTextQuestion()
            self.labelNumPregunta.text = String(self.engine.getId())
            self.labelTipoPregunta.text = self.engine.getTypeQuestion()
            self.userResponses.user = "atlas@gmail.com"
        }
    }
    
    
    func displayError(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    
    @IBAction func userAnswer(_ sender: UIButton) {
        let answer = sender.titleLabel?.text
        let question = Question(id: engine.getId(),question: engine.getTextQuestion(), type: engine.getTypeQuestion(),display: engine.getDisplay())
        var ans = Answer(question: question, answer: 0)
        switch answer!{
        case let str where str.contains("Nada de acuerdo"):
            ans.answer = 1
            //print("Nada de acuerdo")
        case let str where str.contains("Poco de acuerdo"):
            ans.answer = 2
            //print("Poco de acuerdo")
        case let str where str.contains("Ni de acuerdo ni desacuerdo"):
            ans.answer = 3
            //print("Ni de acuerdo ni desacuerdo")
        case let str where str.contains("De acuerdo"):
            ans.answer = 4
            //print("De acuerdo")
        default:
            ans.answer = 5
            //print("Muy de acuerdo")
        }
        userResponses.responses.append(ans)
        //sender.backgroundColor = UIColor.green
        buttonTotalmenteAcuerdo.isEnabled = false
        buttonNiAcuerdoNiDesacuerdo.isEnabled = false
        buttonAcuerdo.isEnabled = false
        buttonTotalmenteDesacuerdo.isEnabled = false
        buttonDesacuerdo.isEnabled = false
        
        if engine.nextQuestion(){
            Task{
                do{
                    try await userResponsesController.insertUserResponses(newUserResponses: userResponses)
                    updateUserResponses(title: "Las respuestas fueron almacenas con éxito en el servidor")
                }catch{
                    displayErrorUserResponses(UserResponsesError.itemNotFound, title: "No se pudo accer almacenar las respuestas en la base de datos")
                }
            }
            
        }else{
            Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: Selector("nextQuestion"), userInfo: nil, repeats: false)
        }
    }
    
    func updateUserResponses(title: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: "Datos almacenados con éxito", preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "Continuar", style: .default)
            alert.addAction(continueAction)
            self.present(alert,animated: true)
        }
    }
     
    func displayErrorUserResponses(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    @objc func nextQuestion(){
        labelPregunta.text = engine.getTextQuestion()
        barraProgreso.progress = engine.getProgress()
        labelTipoPregunta.text = engine.getTypeQuestion()
        
        buttonTotalmenteAcuerdo.isEnabled = true
        buttonNiAcuerdoNiDesacuerdo.isEnabled = true
        buttonAcuerdo.isEnabled = true
        buttonDesacuerdo.isEnabled = true
        buttonTotalmenteDesacuerdo.isEnabled = true
    }
}
    


