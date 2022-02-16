//
//  ViewController.swift
//  Timer App
//
//  Created by Gwinyai Nyatsoka on 19/1/2022.
//

import UIKit

struct Question {
    var answer1: String
    var answer2: String
    var answer3: String
    var correctAnswer: Int
    var answerImage: String
}

protocol ViewControllerDelegate: AnyObject {
    func restartQuiz()
}


class ViewController: UIViewController, ViewControllerDelegate {
    
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    var questions: [Question] = [Question(answer1: "Tiger", answer2: "Leopard", answer3: "Lion", correctAnswer: 3, answerImage: "lion"), Question(answer1: "Lemon", answer2: "Orange", answer3: "Apple", correctAnswer: 2, answerImage: "orange"), Question(answer1: "Bontebok", answer2: "Okapi", answer3: "Giraffe", correctAnswer: 3, answerImage: "giraffe"), Question(answer1: "Pepper", answer2: "Poblano", answer3: "Cubanelle", correctAnswer: 1, answerImage: "pepper"), Question(answer1: "Tiger Salamander Ambystoma Tigrinum", answer2: "Axolotl", answer3: "Spotted Salamander Ambystoma Maculatum", correctAnswer: 2, answerImage: "axolotl"), Question(answer1: "Plantain", answer2: "Monstera", answer3: "Banana", correctAnswer: 3, answerImage: "banana"), Question(answer1: "Donkey", answer2: "Horse", answer3: "Zebra", correctAnswer: 2, answerImage: "horse"), Question(answer1: "Quince", answer2: "Pear", answer3: "Apple", correctAnswer: 2, answerImage: "pear"), Question(answer1: "Dog", answer2: "Wolf", answer3: "Fox", correctAnswer: 1, answerImage: "dog"), Question(answer1: "Rose Haw", answer2: "Floral Fruit", answer3: "Berry", correctAnswer: 3, answerImage: "berry")]
    var score = 0
    var currentQuestion = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let firstQuestion = questions[currentQuestion]
        //answer1Button.setTitle(firstQuestion.answer1, for: .normal)
        let answer1AttributedTitle = NSAttributedString(string: firstQuestion.answer1, attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .heavy)])
        let answer2AttributedTitle = NSAttributedString(string: firstQuestion.answer2, attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .heavy)])
        let answer3AttributedTitle = NSAttributedString(string: firstQuestion.answer3, attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .heavy)])
        answer1Button.setAttributedTitle(answer1AttributedTitle, for: .normal)
        answer2Button.setAttributedTitle(answer2AttributedTitle, for: .normal)
        answer3Button.setAttributedTitle(answer3AttributedTitle, for: .normal)
        questionImageView.image = UIImage(named: firstQuestion.answerImage)

    }
    
    func nextQuestion() {
        if currentQuestion >= questions.count - 1 {
            performSegue(withIdentifier: "ScoreSegue", sender: nil)
            return
        }
        currentQuestion += 1
        
        let answer1AttributedTitle = NSAttributedString(string: questions[currentQuestion].answer1,
                                                        attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .heavy)])
        answer1Button.setAttributedTitle(answer1AttributedTitle, for: .normal)
        
        let answer2AttributedTitle = NSAttributedString(string: questions[currentQuestion].answer2,
                                                        attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .heavy)])
        answer2Button.setAttributedTitle(answer2AttributedTitle, for: .normal)
        
        let answer3AttributedTitle = NSAttributedString(string: questions[currentQuestion].answer3,
                                                        attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .heavy)])
        answer3Button.setAttributedTitle(answer3AttributedTitle, for: .normal)
        
        //answer1Button.setTitle(questions[currentQuestion].answer1, for: .normal)
        //answer2Button.setTitle(questions[currentQuestion].answer2, for: .normal)
        //answer3Button.setTitle(questions[currentQuestion].answer3, for: .normal)
        questionImageView.image = UIImage(named: questions[currentQuestion].answerImage)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ScoreViewController
        destinationVC.score = score
        destinationVC.viewControllerDelegate = self
    }
    
    func restartQuiz() {
        score = 0
        currentQuestion = 0
        scoreLabel.text = "Score: \(score)"
        questionImageView.image = UIImage(named: questions[currentQuestion].answerImage)
        let answer1AttributedTitle = NSAttributedString(string: questions[currentQuestion].answer1,
                                                        attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        answer1Button.setAttributedTitle(answer1AttributedTitle, for: .normal)
        
        let answer2AttributedTitle = NSAttributedString(string: questions[currentQuestion].answer2,
                                                        attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        answer2Button.setAttributedTitle(answer2AttributedTitle, for: .normal)
        
        let answer3AttributedTitle = NSAttributedString(string: questions[currentQuestion].answer3,
                                                        attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        answer3Button.setAttributedTitle(answer3AttributedTitle, for: .normal)
    }
    
    func showCorrectAnswerAlert() {
        score += 1
        scoreLabel.text = "Score: \(score)"
        let alert = UIAlertController(title: "Success!", message: "You got the correct answer!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
            self.nextQuestion()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showIncorrectAnswerAlert() {
        let alert = UIAlertController(title: "Wrong!", message: "You got the answer wrong!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
            self.nextQuestion()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func answer1ButtonDidTouch(_ sender: Any) {
        if questions[currentQuestion].correctAnswer == 1 {
            showCorrectAnswerAlert()
        }
        else {
            showIncorrectAnswerAlert()
        }
    }
    
    @IBAction func answer2ButtonDidTouch(_ sender: Any) {
        if questions[currentQuestion].correctAnswer == 2 {
            showCorrectAnswerAlert()
        } else {
            showIncorrectAnswerAlert()
        }
    }
    
    @IBAction func answer3ButtonDidTouch(_ sender: Any) {
        if questions[currentQuestion].correctAnswer == 3 {
            showCorrectAnswerAlert()
        } else {
            showIncorrectAnswerAlert()
        }
    }
    

}




