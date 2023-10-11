//
//  Answer.swift
//  sel
//
//  Created by Fernando García on 03/10/23.
//

import Foundation
struct Answer:Codable{
    var question_id:Int
    var question:Question
    var answer:Int
}

typealias Answers = [Answer]
