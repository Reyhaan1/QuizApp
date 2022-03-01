//
//  ScoreViewController.swift
//  Timer App
//
//  Created by Gwinyai Nyatsoka on 28/1/2022.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    weak var viewControllerDelegate: ViewControllerDelegate?
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score \(score) / 10"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewControllerDelegate?.restartQuiz()
    }
    
    @IBAction func acceptButtonDidTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}

