//
//  Questions.swift
//  sel
//
//  Created by Fernando García on 03/10/23.
//

import Foundation

struct Response: Codable {
    var questions: [Question] // Assuming you have a Question struct defined
}

struct Question:Codable{
    var id: Int
    var text: String?
    var typeQuestion: String?
    var display: String?
    //let hidden: Bool
}
typealias Questions = [Question]

enum QuestionError: Error, LocalizedError{
    case itemNotFound
}

extension Question{
        
    static func fetchQuestions() async throws->Questions{
        let baseString = "https://sel4c-e2-server-49c8146f2364.herokuapp.com/questions"
        let questionsURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: questionsURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw QuestionError.itemNotFound
        }
        let jsonDecoder = JSONDecoder()
        do {
            let jsonData = try jsonDecoder.decode(Response.self, from: data)
            let questions = jsonData.questions
            return questions
        } catch {
            throw error
        }
    }
}
