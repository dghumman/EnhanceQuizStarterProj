//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let gameModel = GameModel()
    var soundModel = SoundModel()
    
    // MARK: - Outlets
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        soundModel.loadGameStartSound()
        soundModel.playGameStartSound()
        gameModel.displayQuestion(questionLabel: questionField, playButton: playAgainButton)
    }
    // MARK: - Actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        gameModel.questionsAsked += 1
        
        let selectedQuestionDict = gameModel.trivia[gameModel.indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict["Answer"]
        
        if (sender == trueButton &&  correctAnswer == "True") || (sender == falseButton && correctAnswer == "False") {
            gameModel.correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        gameModel.loadNextRound(delay: 2, hideButton: trueButton, hideButton: falseButton, playButton: playAgainButton, questionLabel: questionField)
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        trueButton.isHidden = false
        falseButton.isHidden = false

        gameModel.questionsAsked = 0
        gameModel.correctQuestions = 0
        gameModel.nextRound(hideButton: trueButton, hideButton: falseButton, playButton: playAgainButton, questionLabel: questionField)
    }
    

}

