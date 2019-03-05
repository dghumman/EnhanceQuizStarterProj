

//  GameManger.swift
//  EnhanceQuizStarter
//
//  Created by Anil on 1/14/19.
//  Copyright © 2019 kesarwani. All rights reserved.
//



import Foundation
import GameKit



struct Question {
    let question:String
    let option1: String
    let option2: String
    let option3: String
    let option4: String
    let answer:  String
    let answerType: Int
    
}

struct GameManager{
    
    var questionsAsked = 0 // to store asked question during game (how many questions were asked)
    var correctQuestions = 0 // to store how many question given correctly (how many question was given correctly)
    var indexOfSelectedQuestion = 0 // index of selected question from the trivia array
    var askedQuestionIndex = [Int]() // use of array to store unique generated random (not repetation of random number) index number of trivia.
    
    var currentQuestion: Question? //to store question during from provide quetion
    
    
    var trivia: [Question] = [
        Question(question: "This was the only US President to serve more than two consecutive terms.", option1: "George Washington", option2: "Franklin D. Roosevelt", option3: "Woodrow Wilson", option4: "Andrew Jackson", answer: "Franklin D. Roosevelt", answerType: 4),
        Question(question: "Which of the following countries has the most residents?", option1: "Nigeria", option2: "Russia", option3: "Iran", option4: "Vietnam", answer: "Nigeria", answerType: 4),
        Question(question: "In what year was the United Nations founded?", option1: "1918", option2: "1919", option3: "1945", option4: "1954", answer: "1945", answerType: 4),
        Question(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", option1: "Paris", option2: "Washington D.C.", option3: "New York City", option4: "Boston", answer: "New York City", answerType: 4),
        Question(question: "Which country has most recently won consecutive World Cups in Soccer?", option1: "Italy", option2: "Brazil", option3: "Argetina", option4: "Spain", answer: "Brazil", answerType: 4),
        Question(question: "Which of the following rivers is longest?", option1: "Yangtze", option2: "Mississippi", option3: "Congo", option4: "Mekong", answer: "Mississippi", answerType: 4),
        Question(question: "Which city is the oldest?", option1: "Mexico City", option2: "Cape Town", option3: "San Juan", option4: "Sydney", answer: "Mexico City", answerType: 4),
        Question(question: "Which country was the first to allow women to vote in national elections?", option1: "Poland", option2: "United States", option3: "Sweden", option4: "Senegal", answer: "Poland", answerType: 4),
        Question(question: "Which of these countries won the most medals in the 2012 Summer Games?", option1: "France", option2: "Germany", option3: "Japan", option4: "Great Britain", answer: "Great Britain", answerType: 4),
        Question(question: "Only female koalas can whistle", option1: "True", option2: "False", option3: "None", option4: "None", answer: "False", answerType: 2),
        Question(question: "Blue whales are technically whales", option1: "True", option2: "False", option3: "None", option4: "None", answer: "True", answerType: 2),
        Question(question: "Camels are cannibalistic",option1: "True", option2: "False", option3: "None", option4: "None",  answer: "False", answerType: 2)]
    
    
    //  rendmized questions of trivia
   
    mutating func generateRandomNumber()-> Int{
        var randomNumber:Int = 0 // declare variable to store random number
        var shouldGenerateRandomNumber = true
        while shouldGenerateRandomNumber {
            randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: self.trivia.count)
            
            if askedQuestionIndex.contains(randomNumber) {
                shouldGenerateRandomNumber = true
            }else {
                askedQuestionIndex.append(randomNumber)
                shouldGenerateRandomNumber = false
            }
            
        }
        return randomNumber
    }
    
    // method prodive random questions
    
    mutating func provideQuestion() -> Question {
        
        let randomIndex = generateRandomNumber()
        
        let question = trivia[randomIndex]
        
        currentQuestion = question
        
        return question
        
    }
    
    // checking correct answer of question in action of selected button(option)
    
    func checkCorrectAnswer(selectedQuestion: Question, bottonTittle: String) -> Bool{
    
        if  selectedQuestion.answer == bottonTittle{
            return true
        } else {
            return false
        }
    
}
    


}

