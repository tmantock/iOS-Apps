//
//  ViewController.swift
//  Quizzler
//
//  Created by Tevin Mantock on 25/08/2015.
//  Copyright (c) 2017 Tevin Mantock. All rights reserved.
//

import UIKit
import ProgressHUD

class ViewController: UIViewController {
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var finished : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0

    //Place your instance variables here
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
    }
    
    func updateUI() {
        let questionCount = allQuestions.questions.count
        questionLabel.text = allQuestions.questions[questionNumber].questionText
        progressLabel.text = "\(questionNumber + 1)/\(questionCount)"
        scoreLabel.text = "Correct: \(score)"
        
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(questionCount)) * CGFloat(questionNumber + 1)
    }
    
    func nextQuestion() {
        if questionNumber < allQuestions.questions.count - 1 {
            questionNumber += 1
            
            updateUI()
        } else {
            finished = true
            let alert = UIAlertController(title: "Awesome", message: "You have finished all the questions. Would you like to try again?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { (_) in
                self.startOver()
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func checkAnswer() {
        if pickedAnswer == allQuestions.questions[questionNumber].answer && !finished {
            score += 1
            ProgressHUD.showSuccess("Correct!")
        } else {
            ProgressHUD.showError("Wrong!")
        }
        
        nextQuestion()
    }
    
    func startOver() {
        questionNumber = 0
        score = 0
        pickedAnswer = false
        finished = false
        
        updateUI()
    }
}
