//
//  ViewCuestFinal.swift
//  sel
//
//  Created by Julia🌺 Cascelli🌊 on 08/10/23.
//

import UIKit

class ViewCuestFinal: UIViewController {
    
    @IBOutlet weak var labelTipoPregunta: UILabel!
    
    @IBOutlet weak var barraProgreso: UIProgressView!
    
    @IBOutlet weak var numPregunta: UILabel!
    
    @IBOutlet weak var textPregunta: UITextView!
    
    @IBOutlet weak var buttonTotalmenteDesacuerdo: UIButton!
    
    @IBOutlet weak var buttonDesacuerdo: UIButton!
    
    @IBOutlet weak var buttonNideacuerdoNidesacuerdo: UIButton!
    
    @IBOutlet weak var buttonDeacuerdo: UIButton!
    
    @IBOutlet weak var buttonTotalmenteDeacuerdo: UIButton!
    
    
    var engine=EcomplexityEngine()
    var userResponsesController = UserResponsesController()
    
    let defaults = UserDefaults.standard
    
    var answers1to12: [Answer] = []
    var answers13to24: [Answer] = []
    var answers25to41: [Answer] = []
    var answers42to50: [Answer] = []

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
        
        buttonNideacuerdoNidesacuerdo.tintColor = UIColor.white
        buttonNideacuerdoNidesacuerdo.layer.cornerRadius = 25
        buttonNideacuerdoNidesacuerdo.clipsToBounds = true
        buttonNideacuerdoNidesacuerdo.layer.borderWidth = 1
        buttonNideacuerdoNidesacuerdo.layer.borderColor = UIColor.black.cgColor
        
        buttonDeacuerdo.tintColor = UIColor.white
        buttonDeacuerdo.layer.cornerRadius = 25
        buttonDeacuerdo.clipsToBounds = true
        buttonDeacuerdo.layer.borderWidth = 1
        buttonDeacuerdo.layer.borderColor = UIColor.black.cgColor
        
        buttonTotalmenteDeacuerdo.tintColor = UIColor.white
        buttonTotalmenteDeacuerdo.layer.cornerRadius = 25
        buttonTotalmenteDeacuerdo.clipsToBounds = true
        buttonTotalmenteDeacuerdo.layer.borderWidth = 1
        buttonDeacuerdo.layer.borderColor = UIColor.black.cgColor
        labelTipoPregunta.isEnabled = false
        
        
    }
    
    func updateUI(with questions:Questions){
        DispatchQueue.main.async {
            self.engine.initialize(q: questions)
            self.barraProgreso.progress = self.engine.getProgress()
            self.textPregunta.text = self.engine.getTextQuestion()
            self.numPregunta.text = String(self.engine.getId())
            self.labelTipoPregunta.text = self.engine.getTypeQuestion()
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
        let userId = defaults.integer(forKey: "user_id")
        let answer = sender.titleLabel?.text
        let questionid = engine.getId()
        // let question = Question(id: engine.getId(),question: engine.getTextQuestion(), type: engine.getTypeQuestion(),display: engine.getDisplay())
        var ans = Answer(userId: userId, questionId: engine.getId(), answer: 0)
        switch answer!{
        case let str where str.contains("Totalmente en desacuerdo"):
            ans.answer = 1
            //print("Nada de acuerdo")
        case let str where str.contains("En desacuerdo"):
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
        switch questionid {
        case 1...12:
            answers1to12.append(ans)
        case 13...24:
            answers13to24.append(ans)
        case 25...41:
            answers25to41.append(ans)
        case 42...50:
            answers42to50.append(ans)
        default:
            break
        }

    
        //sender.backgroundColor = UIColor.green
        buttonTotalmenteDeacuerdo.isEnabled = false
        buttonNideacuerdoNidesacuerdo.isEnabled = false
        buttonDeacuerdo.isEnabled = false
        buttonTotalmenteDesacuerdo.isEnabled = false
        buttonDesacuerdo.isEnabled = false
        Task{
            do{
                engine.nextQuestion()
                try await userResponsesController.insertUserResponses(newUserResponses: ans)
                updateUserResponses(title: "Las respuestas fueron almacenas con éxito en el servidor")
            }catch{
                /*displayErrorUserResponses(UserResponsesError.itemNotFound, title: "No se pudo accer almacenar las respuestas en la base de datos")*/
                print("holi")

            }
        }
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("nextQuestion"), userInfo: nil, repeats: false)
        if questionid == 50 {
            self.performSegue(withIdentifier: "ToResultFinal", sender: self)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToResultFinal", let destinationVC = segue.destination as? resultEncInicial {
            destinationVC.answers1to12 = self.answers1to12
            destinationVC.answers13to24 = self.answers13to24
            destinationVC.answers25to41 = self.answers25to41
            destinationVC.answers42to50 = self.answers42to50
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
        textPregunta.text = engine.getTextQuestion()
        barraProgreso.progress = engine.getProgress()
        labelTipoPregunta.text = engine.getTypeQuestion()
        numPregunta.text = String(engine.getId())
        
        buttonTotalmenteDeacuerdo.isEnabled = true
        buttonNideacuerdoNidesacuerdo.isEnabled = true
        buttonDesacuerdo.isEnabled = true
        buttonDesacuerdo.isEnabled = true
        buttonTotalmenteDesacuerdo.isEnabled = true
    }
    
    
    
    func displayErrorUserResponsess(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
         
}
/*import UIKit
 
 class ViewCuestFinal: UIViewController {
 
 
 
 @IBOutlet weak var labelTipoPregunta: UILabel!
 
 @IBOutlet weak var barraProgreso: UIProgressView!
 
 @IBOutlet weak var numPregunta: UILabel!
 
 @IBOutlet weak var pregunta: UILabel!
 
 @IBOutlet weak var buttonTotalmenteDesacuerdo: UIButton!
 
 @IBOutlet weak var buttonDesacuerdo: UIButton!
 
 @IBOutlet weak var buttonNideacuerdoNidesacuerdo: UIButton!
 
 @IBOutlet weak var buttonDeacuerdo: UIButton!
 
 @IBOutlet weak var buttonTotalmenteDeacuerdo: UIButton!
 
 
 var engine=EcomplexityEngine()
 var userResponsesController = UserResponsesController()
 
 let defaults = UserDefaults.standard
 
 
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
 
 buttonNideacuerdoNidesacuerdo.tintColor = UIColor.white
 buttonNideacuerdoNidesacuerdo.layer.cornerRadius = 25
 buttonNideacuerdoNidesacuerdo.clipsToBounds = true
 buttonNideacuerdoNidesacuerdo.layer.borderWidth = 1
 buttonNideacuerdoNidesacuerdo.layer.borderColor = UIColor.black.cgColor
 
 buttonDeacuerdo.tintColor = UIColor.white
 buttonDeacuerdo.layer.cornerRadius = 25
 buttonDeacuerdo.clipsToBounds = true
 buttonDeacuerdo.layer.borderWidth = 1
 buttonDeacuerdo.layer.borderColor = UIColor.black.cgColor
 
 buttonTotalmenteDeacuerdo.tintColor = UIColor.white
 buttonTotalmenteDeacuerdo.layer.cornerRadius = 25
 buttonTotalmenteDeacuerdo.clipsToBounds = true
 buttonTotalmenteDeacuerdo.layer.borderWidth = 1
 buttonDeacuerdo.layer.borderColor = UIColor.black.cgColor
 labelTipoPregunta.isEnabled = false
 
 
 }
 
 func updateUI(with questions:Questions){
 DispatchQueue.main.async {
 self.engine.initialize(q: questions)
 self.barraProgreso.progress = self.engine.getProgress()
 self.pregunta.text = self.engine.getTextQuestion()
 self.numPregunta.text = String(self.engine.getId())
 self.labelTipoPregunta.text = self.engine.getTypeQuestion()
 }
 }
 
 
 func displayError(_ error: Error, title: String) {
 DispatchQueue.main.async {
 let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
 alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
 self.present(alert, animated: true, completion: nil)
 }
 }
 
 
 @IBAction func userAnswer(_ sender: Any) {
 let userId = defaults.integer(forKey: "user_id")
 let answer = sender.titleLabel?.text
 let questionid = engine.getId()
 // let question = Question(id: engine.getId(),question: engine.getTextQuestion(), type: engine.getTypeQuestion(),display: engine.getDisplay())
 var ans = Answer(userId: userId, questionId: engine.getId(), answer: 0)
 switch answer!{
 case let str where str.contains("Totalmente en desacuerdo"):
 ans.answer = 1
 //print("Nada de acuerdo")
 case let str where str.contains("En desacuerdo"):
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
 
 //sender.backgroundColor = UIColor.green
 buttonTotalmenteDeacuerdo.isEnabled = false
 buttonNideacuerdoNidesacuerdo.isEnabled = false
 buttonDeacuerdo.isEnabled = false
 buttonTotalmenteDesacuerdo.isEnabled = false
 buttonDesacuerdo.isEnabled = false
 Task{
 do{
 engine.nextQuestion()
 try await userResponsesController.insertUserResponses(newUserResponses: ans)
 updateUserResponses(title: "Las respuestas fueron almacenas con éxito en el servidor")
 }catch{
 displayErrorUserResponses(UserResponsesError.itemNotFound, title: "No se pudo accer almacenar las respuestas en la base de datos")
 }
 }
 
 Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("nextQuestion"), userInfo: nil, repeats: false)
 
 
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
 pregunta.text = engine.getTextQuestion()
 barraProgreso.progress = engine.getProgress()
 labelTipoPregunta.text = engine.getTypeQuestion()
 numPregunta.text = String(engine.getId())
 
 buttonTotalmenteDeacuerdo.isEnabled = true
 buttonNideacuerdoNidesacuerdo.isEnabled = true
 buttonDesacuerdo.isEnabled = true
 buttonDesacuerdo.isEnabled = true
 buttonTotalmenteDesacuerdo.isEnabled = true
 }
 
 
 
 
 
 
 
 
 
 
 func displayErrorUserResponsess(_ error: Error, title: String) {
 DispatchQueue.main.async {
 let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
 alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
 self.present(alert, animated: true, completion: nil)
 }
 }
 @objc func nextQuestionn(){
 pregunta.text = engine.getTextQuestion()
 barraProgreso.progress = engine.getProgress()
 numPregunta.text = engine.getTypeQuestion()
 
 buttonDesacuerdo.isEnabled = true
 buttonTotalmenteDesacuerdo.isEnabled = true
 buttonNideacuerdoNidesacuerdo.isEnabled = true
 buttonDeacuerdo.isEnabled = true
 buttonTotalmenteDeacuerdo.isEnabled = true
 }
 
 @IBAction func performNextPage(_ sender: Any) {
 let questionID = defaults.integer(forKey: "questionid")
 if questionID == 50 {
 self.performSegue(withIdentifier: "ToResults", sender: self)
 }
 
 }
 }
 
*/
