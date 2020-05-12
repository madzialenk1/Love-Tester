//
//  TestViewController.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 11/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var fifthButton: UIButton!
    
   
    var testBrain = TestBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = testBrain.getQuestionText()
        pageLabel.text = "\(testBrain.questionNumber + 1) of 38"
        pageLabel.layer.masksToBounds = true
        pageLabel.layer.cornerRadius = pageLabel.bounds.size.height * 0.5
        questionLabel.adjustsFontSizeToFitWidth = true
        questionLabel.minimumScaleFactor = 0.2
        
    }
    
    @IBAction func firstAnswerPressed(_ sender: UIButton) {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        sender.pulsate()
        
    }
    @IBAction func secondAnswerPressed(_ sender: UIButton) {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        sender.pulsate()
       
    }
    @IBAction func thirdAnswerPressed(_ sender: UIButton) {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        sender.pulsate()
        
    }
    @IBAction func fourthAnswerPressed(_ sender: UIButton) {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        sender.pulsate()
  
    }
    @IBAction func fifthAnswerPressed(_ sender: UIButton) {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        sender.pulsate()

    }
    
    @objc func updateUI(){
        
        testBrain.nextQuestion()
        questionLabel.text = testBrain.getQuestionText()
        pageLabel.text = "\(testBrain.questionNumber + 1) of 45"
    }
    
    
}


