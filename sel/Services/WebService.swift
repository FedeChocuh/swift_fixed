//
//  WebService.swift
//  sel
//
//  Created by Fernando García on 28/09/23.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
}

struct LoginResponse : Codable {
    let token : String?
    let message : String?
    let success : Bool?
    
    let user_id: Int?
    let name: String?
    let lastname: String?
    let email: String?
    let age: Int?
    let gender: String?
    let country_id: String?
    let country_name: String?
    let university_id: Int?
    let university_name: String?
}

//----------------------------------------

struct RegisterRequestBody: Codable {
    let name: String
    let password: String
    let email: String
    let gender: String
    let country_id: String
    let age: Int
    let university_id: Int
    
}

struct RegisterResponse: Codable {
    let values: String?
    let message: String?
    let success: Bool?
}

//----------------------------------------
class Webservice {
    func login(email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        let defaults = UserDefaults.standard
        
        guard let url = URL(string: "https://sel4c-e2-server-49c8146f2364.herokuapp.com/users/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) {(data,response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            guard let token = loginResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let userId = loginResponse.user_id else {
                completion(.failure(.invalidCredentials))
                return
            }
            defaults.setValue(userId, forKey: "user_id")
            guard let name = loginResponse.name else {
                completion(.failure(.invalidCredentials))
                return
            }
            defaults.setValue(name, forKey: "name")
            guard let email = loginResponse.email else {
                completion(.failure(.invalidCredentials))
                return
            }
            defaults.setValue(email, forKey: "email")
            guard let age = loginResponse.age else {
                completion(.failure(.invalidCredentials))
                return
            }
            defaults.setValue(age, forKey: "age")
            guard let gender = loginResponse.gender else {
                completion(.failure(.invalidCredentials))
                return
            }
            defaults.setValue(gender, forKey: "gender")
            guard let universityId = loginResponse.university_id else {
                completion(.failure(.invalidCredentials))
                return
            }
            defaults.setValue(universityId, forKey: "university_id")
            guard let universityName = loginResponse.university_name else {
                completion(.failure(.invalidCredentials))
                return
            }
            defaults.setValue(universityName, forKey: "university_name")
            guard let countryId = loginResponse.country_id else {
                completion(.failure(.invalidCredentials))
                return
            }
            defaults.setValue(countryId, forKey: "country_id")
            guard let countryName = loginResponse.country_name else {
                completion(.failure(.invalidCredentials))
                return
            }
            defaults.setValue(countryName, forKey: "country_name")
            
            print(defaults)
            
            completion(.success(token))
            
        } .resume()
    }
    
    func register(name: String, password: String, country_id: String, gender: String, age: Int, email: String, university_id: Int,completion: @escaping (Result<String, AuthenticationError>) -> Void){
        
        guard let url = URL(string: "https://sel4c-e2-server-49c8146f2364.herokuapp.com/users") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = RegisterRequestBody(name: name, password: password, email:email, gender: gender, country_id: country_id, age:age, university_id:university_id)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) {(data,response, error) in
            print("Response:", response)
            print("Error:", error)
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let values = registerResponse.values else {
                completion(.failure(.custom(errorMessage: "No data was stored")))
                return
            }
            
            completion(.success(values))
            
        }.resume()
        
    }
}
