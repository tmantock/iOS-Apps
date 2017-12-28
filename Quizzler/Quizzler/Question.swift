//
//  Question.swift
//  Quizzler
//
//  Created by Tevin Mantock on 12/23/17.
//  Copyright © 2017 Tevin Mantock. All rights reserved.
//

import Foundation

struct Question {
    let questionText : String
    let answer : Bool
    
    init(text : String, correctAnswer : Bool) {
        self.questionText = text
        self.answer = correctAnswer
    }
}
