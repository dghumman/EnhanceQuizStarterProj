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
    
    var gameManager = GameManager()
    var soundManager = SoundManager()
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var option4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soundManager.loadGameStartSound()
        soundManager.loadCorrectSound()
        // Play start sound
        soundManager.playGameStartSound()
        
        displayQuestion()
    }
    

    
   
    
     // update UI with question
  func displayQuestion() {
    
    let question = gameManager.provideQuestion()
        questionField.text = question.question
        //print(question)
        playAgainButton.isHidden = true
    
     //set the UIBottons according to answerTypes (between 2 answer type and 4 answer type)...
   
    if question.answerType == 2 {
        trueButton.setTitle(question.option1, for: UIControlState.normal)
        //print(question.option1)
        option2.setTitle(question.option2, for: UIControlState.normal)
        falseButton.isHidden = true
        option4.isHidden = true
  
    } else if question.answerType == 4 {
        trueButton.setTitle(question.option1, for: UIControlState.normal)
        option2.setTitle(question.option2, for: UIControlState.normal)
        falseButton.setTitle(question.option3, for: UIControlState.normal)
        //print(question.option3)
        option4.setTitle(question.option4, for: UIControlState.normal)
        trueButton.isHidden = false
        option2.isHidden = false
        falseButton.isHidden = false
        option4.isHidden = false
    }
    
    }
 
   
    
    //showing the game score
    func displayScore() {
        // Hide the answer uttons
        trueButton.isHidden = true
        falseButton.isHidden = true
        option2.isHidden = true
        option4.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(gameManager.correctQuestions) out of \(gameManager.questionsAsked) correct!"
    }
    
    
    // proceed to next round or end of game
    func nextRound() {
        if gameManager.questionsAsked == gameManager.trivia.count {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    
    
     // load round
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    
    
    // get current question and current answer to then indicate correct answer
    @IBAction func checkAnswer(_ sender: UIButton) {
        guard let selectQuestion = gameManager.currentQuestion else {
            print("gameManager.currentQuestion is nil")
            return
        }
 
        // Increment the questions asked counter
        gameManager.questionsAsked += 1
    
        let bottonTittle = sender.titleLabel?.text
        //print(sender.currentTitle!)
        
        let isCorrectAnswer = gameManager.checkCorrectAnswer(selectedQuestion: selectQuestion, bottonTittle: bottonTittle ?? "")
        
        if isCorrectAnswer {
            
            // Here this is true
            soundManager.playCorrectSound()
            questionField.text = "Correct!"
            gameManager.correctQuestions += 1
        } else {
            let answer: String = gameManager.currentQuestion!.answer
            questionField.text = "Sorry, wrong answer!, the correct answer was \(answer)."
        }
        
        loadNextRound(delay: 2)
        
    }
        
    
    
    
    // start new game when play again is pressed, resetting counter values for questions
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        trueButton.isHidden = false
        falseButton.isHidden = false
        option2.isHidden = false
        option4.isHidden = false
        
        gameManager.questionsAsked = 0
        gameManager.correctQuestions = 0
        nextRound()
    }
    

}

