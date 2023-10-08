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
    let name: String
    let password: String
}

struct LoginResponse : Codable {
    let token : String?
    let message : String?
    let success : Bool?
}

//----------------------------------------

struct RegisterRequestBody: Codable {
    let name: String
    let password: String
    let email: String
    let gender: String
    let country_id: String
    let age: Int
    let university: String
    
}

struct RegisterResponse: Codable {
    let values: String?
    let message: String?
    let success: Bool?
}

//----------------------------------------
class Webservice {
    func login(name: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: "http://localhost:3001/users") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(name: name, password: password)
        
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
            
            completion(.success(token))
            
        } .resume()
    }
    
    func register(name: String, password: String, country_id: String, gender: String, age: Int, email: String, university: String,completion: @escaping (Result<String, AuthenticationError>) -> Void){
        
        guard let url = URL(string: "http://localhost:3001/users") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = RegisterRequestBody(name: name, password: password, email:email, gender: gender, country_id: country_id, age:age, university:university)
        
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
