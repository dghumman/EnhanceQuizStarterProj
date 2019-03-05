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
    var currentQuestion: Question?
    var askedQuestionIndex = [Int]()
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0

    var trivia: [Question] = [
        Question(question: "When was the 19th Amendment passed?", option1: "1920", option2: "1940", option3: "1919", option4: "1917", answer: "1920", answerType: 4),
        
        Question(question: "Which has the highest population?", option1: "Asia", option2: "India", option3: "China", option4: "Japan", answer: "Asia", answerType: 4),
        
        Question(question: "Best OS on mobile?", option1: "iOS", option2: "Andriod", option3: "None", option4: "None", answer: "iOS", answerType: 2),
        
        Question(question: "Only female koalas can whistle", option1: "True", option2: "False", option3: "None", option4: "None", answer: "False", answerType: 2),
        
        Question(question: "Blue whales are technically whales", option1: "True", option2: "False", option3: "None", option4: "None", answer: "True", answerType: 2),
        
        Question(question: "Camels are cannibalistic",option1: "True", option2: "False", option3: "None", option4: "None",  answer: "False", answerType: 2)]
    
    
    mutating func generateRandomNumber()-> Int{
        var randomNumber: Int = 0
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
    
    mutating func provideQuestion() -> Question {
        
        let randomIndex = generateRandomNumber()
        
        let question = trivia[randomIndex]
        
        currentQuestion = question
        
        return question
        
    }
    
    
    func checkCorrectAnswer(selectedQuestion: Question, bottonTittle: String) -> Bool{
    
        if  selectedQuestion.answer == bottonTittle{
            return true
        } else {
            return false
        }
    
}
    


}

