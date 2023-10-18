//
//  QuizService.swift
//  sel
//
//  Created by Fernando García on 17/10/23.
//

import Foundation

enum AuthenticationQuizError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct QuizDone: Codable {
    let message: String?
    let done: Int?
    let count: Int?
}

class QuizService {
    func quiz(message: String, done: Int, count: Int,completion: @escaping (Result<String, AuthenticationError>) -> Void){
        let defaults = UserDefaults.standard
        let userid = defaults.integer(forKey: "name")
        
        guard let url = URL(string: "https://sel4c-e2-server-49c8146f2364.herokuapp.com/users/start-quiz/\(userid)") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        print(userid)
        
        let body = QuizDone(message: message, done: done, count: count)
        
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
            
            guard let quizResponse = try? JSONDecoder().decode(QuizDone.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let message = quizResponse.message else {
                completion(.failure(.invalidCredentials))
                return
            }
            defaults.setValue(message, forKey: "quiz_message")
            
            guard let count = quizResponse.count else {
                completion(.failure(.invalidCredentials))
                return
            }
            defaults.setValue(count, forKey: "quiz_count")
            
            guard let done = quizResponse.done else {
                completion(.failure(.invalidCredentials))
                return
            }
            defaults.setValue(done, forKey: "quiz_done")

            
        }
    }
}
