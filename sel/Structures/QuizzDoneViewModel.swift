//
//  QuizzDoneViewModel.swift
//  sel
//
//  Created by Fernando García on 17/10/23.
//

import Foundation

class QuizDoneViewModel {
    var message: String = ""
    var done: Int = 0
    var count: Int = 0

    
    func Done() {
        let defaults = UserDefaults.standard
        
        QuizService().quiz(message: message, done: done, count: count) {  result in
            switch result {
            case .success(let boolDone):
                defaults.setValue(boolDone, forKey: "boolDone")

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

