//
//  LoginViewModel.swift
//  sel
//
//  Created by Fernando García on 28/09/23.
//

import Foundation

class LoginViewModel {
    var email: String = ""
    var password: String = ""
    @Published var isAuthenticated: Bool = false
    
    
    

    func Login() {
        
        let defaults = UserDefaults.standard
        
        Webservice().login(email: email, password: password) { result in
            switch result {
            case .success(let token):
                defaults.setValue(token, forKey: "jsonwebtoken")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

class QuizzDoneViewwModel {
    var message: String = ""
    var done: Int = 0
    var count: Int = 0

    
    func Done() {
        let defaults = UserDefaults.standard
        
        Webservice().quizz(message: message, done: done, count: count) {  result in
            switch result {
            case .success(let boolDone):
                defaults.setValue(boolDone, forKey: "boolDone")

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
