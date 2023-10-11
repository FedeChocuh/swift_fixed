//
//  ViewCuestFinal.swift
//  sel
//
//  Created by Julia🌺 Cascelli🌊 on 08/10/23.
//

import UIKit

class ViewCuestFinal: UIViewController {

       
    
    
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
    

    /*
    struct Question: Codable {
        var id: Int
        var question: String
        var type: String
    }

    struct Answer: Codable {
        var question: Question
        var answer: Int
    }

    struct UserResponses: Codable {
        var user: String
        var responses: [Answer]
    }

    enum QuestionError: LocalizedError {
        case serverError
        case itemNotFound
        
        var errorDescription: String? {
            switch self {
            case .serverError:
                return "A server error occurred."
            case .itemNotFound:
                return "The item was not found."
            }
        }
    }

    enum UserResponsesError: LocalizedError {
        case serverError
        case itemNotFound
        
        var errorDescription: String? {
            switch self {
            case .serverError:
                return "A server error occurred."
            case .itemNotFound:
                return "The item was not found."
            }
        }
    }
    
    extension Question {
        static func fetchQuestions() async throws -> [Question] {
            let url = URL(string: "http://localhost:3000/questions")!
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw QuestionError.serverError
            }
            let questions = try JSONDecoder().decode([Question].self, from: data)
            return questions
        }
    }
    
    class UserResponsesController {
        func insertUserResponses(newUserResponses: UserResponses) async throws {
            let url = URL(string: "http://localhost:3000/questions_results")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonData = try JSONEncoder().encode(newUserResponses)
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw UserResponsesError.serverError
            }
        }
    }

     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estiloBotones()
        
        Task{
            do{
                let questions = try await Question.fetchQuestions()
                updateUI(with: [questions])
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
            self.labelTipoPregunta.text = self.engine.getTypeQuestion()
            self.userResponses.user = "user@tec.mx"
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
        let question = Question(id: engine.getId(),question: engine.getTextQuestion(), type: engine.getTypeQuestion())
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
     */
    
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
        numPregunta.text = engine.getTypeQuestion()
        
        buttonDesacuerdo.isEnabled = true
        buttonTotalmenteDesacuerdo.isEnabled = true
        buttonNideacuerdoNidesacuerdo.isEnabled = true
        buttonDeacuerdo.isEnabled = true
        buttonTotalmenteDeacuerdo.isEnabled = true
    }
}
