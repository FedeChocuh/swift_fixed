//
//  UserResponsesController.swift
//  sel
//
//  Created by Fernando García on 03/10/23.
//

import Foundation

enum UserResponsesError: Error, LocalizedError{
    case itemNotFound
}
class UserResponsesController{
    let defaults = UserDefaults.standard
    let baseString = "https://sel4c-e2-server-49c8146f2364.herokuapp.com/questions/answers"
    func insertUserResponses(newUserResponses:Answer)async throws->Void{
        let insertURL = URL(string: baseString)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(newUserResponses)
        request.httpBody = jsonData
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw UserResponsesError.itemNotFound}
        
        let questionID = newUserResponses.questionId
        defaults.setValue(questionID, forKey: "questionid")
        
        let answer = newUserResponses.answer
        defaults.setValue(answer, forKey: "answers")
        
    }
    
}
