//
//  RegisterViewModel.swift
//  sel
//
//  Created by Fernando García on 02/10/23.
//
import Foundation

   class RegisterViewModel {
        var name: String = ""
        var password: String = ""
        var email: String = ""
        var gender: String = ""
        var country_id: String = ""
        var age: Int = 0
        var university_id: Int = 0
        
        // Agrega la propiedad webService
        var webService: WebServiceProtocol
        
        init(webService: WebServiceProtocol) {
            self.webService = webService
        }
        
       
    func Register() {
        
        let defaults = UserDefaults.standard
        
        Webservice().register(name: name, password: password, country_id: country_id, gender: gender, age: age,email: email, university_id: university_id) { result in
            switch result {
            case .success(let values):
                defaults.setValue(values, forKey: "../db")
              
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
