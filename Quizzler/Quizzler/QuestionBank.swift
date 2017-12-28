//
//  QuestionBank.swift
//  Quizzler
//
//  Created by Tevin Mantock on 12/23/17.
//  Copyright © 2017 London App Brewery. All rights reserved.
//

import Foundation

class QuestionBank {
    var questions : [Question]
    
    init() {
        questions = [Question]()
        
        addQuestion(question: Question(text: "Valentine\'s day is banned in Saudi Arabia.", correctAnswer: true))
        
        addQuestion(question: Question(text: "A slug\'s blood is green.", correctAnswer: true))
        
        addQuestion(question: Question(text: "Approximately one quarter of human bones are in the feet.", correctAnswer: true))
        
        addQuestion(question: Question(text: "The total surface area of two human lungs is approximately 70 square metres.", correctAnswer: true))
        
        addQuestion(question: Question(text: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", correctAnswer: true))
        
        addQuestion(question: Question(text: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", correctAnswer: false))
        
        addQuestion(question: Question(text: "It is illegal to pee in the Ocean in Portugal.", correctAnswer: true))
        
        addQuestion(question: Question(text: "You can lead a cow down stairs but not up stairs.", correctAnswer: false))
        
        addQuestion(question: Question(text: "Google was originally called \"Backrub\".", correctAnswer: true))
        
        addQuestion(question: Question(text: "Buzz Aldrin\'s mother\'s maiden name was \"Moon\".", correctAnswer: true))
        
        addQuestion(question: Question(text: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", correctAnswer: false))
        
        addQuestion(question: Question(text: "No piece of square dry paper can be folded in half more than 7 times.", correctAnswer: false))
        
        addQuestion(question: Question(text: "Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.", correctAnswer: true))
    }
    
    func addQuestion(question : Question) {
        questions.append(question)
    }
}
