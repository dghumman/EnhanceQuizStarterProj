//
//  GameModel.swift
//  EnhanceQuizStarter
//
//  Created by Devin Ghumman on 3/4/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import GameKit

class GameModel {
    let trivia: [[String : String]] = [
        ["Question": "Only female koalas can whistle", "Answer": "False"],
        ["Question": "Blue whales are technically whales", "Answer": "True"],
        ["Question": "Camels are cannibalistic", "Answer": "False"],
        ["Question": "All ducks are birds", "Answer": "True"]
    ]
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    
    
    func displayQuestion(questionLabel: UILabel, playButton: UIButton) {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
        let questionDictionary = trivia[indexOfSelectedQuestion]
        questionLabel.text = questionDictionary["Question"]
        playButton.isHidden = true
    }
    
    func displayScore(hideButton button0: UIButton, hideButton button1: UIButton, playButton: UIButton, questionLabel: UILabel) {
        // Hide the answer uttons
        button0.isHidden = true
        button1.isHidden = true
        
        // Display play again button
        playButton.isHidden = false
        
        questionLabel.text = "Way to go! You got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    func nextRound(hideButton button0: UIButton, hideButton button1: UIButton, playButton: UIButton, questionLabel: UILabel) {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore(hideButton: button0, hideButton: button1, playButton: playButton, questionLabel: questionLabel)
            
        } else {
            // Continue game
            displayQuestion(questionLabel: questionLabel, playButton: playButton)
        }
    }
    
    func loadNextRound(delay seconds: Int, hideButton button0: UIButton, hideButton button1: UIButton, playButton: UIButton, questionLabel: UILabel) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound(hideButton: button0, hideButton: button1, playButton: playButton, questionLabel: questionLabel)
        }
    }
    
    
    
    
}
