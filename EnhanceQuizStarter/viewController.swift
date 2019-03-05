import UIKit
import GameKit
import AudioToolbox



class ViewController: UIViewController {
    
    var gameManager = GameManager()
    var soundManager = SoundManager()
    
    
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var option4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllSounds()
        soundManager.playGameStartSound()
        
        displayQuestion()
    }
    
    func loadAllSounds()
    {
        soundManager.loadGameStartSound()
        soundManager.loadCorrectSound()
        soundManager.loadWrongSound()
    }

    
   
    
  func displayQuestion() {
    
    let question = gameManager.provideQuestion()
        questionField.text = question.question
        playAgainButton.isHidden = true
    
   
    if question.answerType == 2 {
        trueButton.setTitle(question.option1, for: UIControl.State.normal)
        option2.setTitle(question.option2, for: UIControl.State.normal)
        falseButton.isHidden = true
        option4.isHidden = true
  
    } else if question.answerType == 4 {
        trueButton.setTitle(question.option1, for: UIControl.State.normal)
        option2.setTitle(question.option2, for: UIControl.State.normal)
        falseButton.setTitle(question.option3, for: UIControl.State.normal)
        option4.setTitle(question.option4, for: UIControl.State.normal)
        trueButton.isHidden = false
        option2.isHidden = false
        falseButton.isHidden = false
        option4.isHidden = false
    }
    
    }
 
   
    
    func displayScore() {
        trueButton.isHidden = true
        falseButton.isHidden = true
        option2.isHidden = true
        option4.isHidden = true
        
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(gameManager.correctQuestions) out of \(gameManager.questionsAsked) correct!"
    }
    
    
    func nextRound() {
        if gameManager.questionsAsked == gameManager.trivia.count {
            displayScore()
        } else {
            displayQuestion()
        }
    }
    
    
    
    func loadNextRound(delay seconds: Int) {
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        trueButton.isHidden = false
        falseButton.isHidden = false
        option2.isHidden = false
        option4.isHidden = false
        
        gameManager.askedQuestionIndex = []
        gameManager.questionsAsked = 0
        gameManager.correctQuestions = 0
        nextRound()
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        guard let selectQuestion = gameManager.currentQuestion else {
            print("gameManager.currentQuestion is nil")
            return
        }
 
        gameManager.questionsAsked += 1
    
        let bottonTittle = sender.titleLabel?.text
        let isCorrectAnswer = gameManager.checkCorrectAnswer(selectedQuestion: selectQuestion, bottonTittle: bottonTittle ?? "")
        
        if isCorrectAnswer {
            soundManager.playCorrectSound()
            questionField.text = "Correct!"
            gameManager.correctQuestions += 1
        } else {
            let answer: String = gameManager.currentQuestion!.answer
            soundManager.playWrongSound()
            questionField.text = "Sorry, wrong answer!, the correct answer was \(answer)."
        }
        
        loadNextRound(delay: 2)
        
    }
        
    
    

    

}

