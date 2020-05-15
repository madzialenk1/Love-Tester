//
//  TestViewController.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 11/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import UIKit
import RealmSwift

class TestViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var buttons: [UIButton]!
    
    var testBrain = TestBrain()
    let realm = try! Realm()
    var numberOfItemsInDataBase = 0
    
    var items: Results<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = testBrain.getQuestionText()
        pageLabel.text = "\(testBrain.questionNumber + 1) of 38"
        pageLabel.layer.masksToBounds = true
        pageLabel.layer.cornerRadius = pageLabel.bounds.size.height * 0.5
        questionLabel.adjustsFontSizeToFitWidth = true
        questionLabel.minimumScaleFactor = 0.2
        
        
     
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }
    
    @IBAction func answerButtonClicked(_ sender: UIButton){
        self.buttons.forEach { (button) in
            if button == sender {
            button.setImage(UIImage(named: "button_clicked"), for: .normal)
            button.pulsate()
            }
                else {
                button.setImage(UIImage(named: "buttonTest"), for: .normal)
            }
                       
        }
        if let indexOfButtonPressed = buttons.firstIndex(of: sender){
            
            if !objectExist(id: String(testBrain.questionNumber+1)) {
            let newItem = Item()
            newItem.t = String (testBrain.questionNumber+1)
            newItem.a = labels[indexOfButtonPressed].text!
            save(item: newItem)
                numberOfItemsInDataBase += 1
                }
            else {
                try! realm.write {
                items = realm.objects(Item.self)
                items[testBrain.questionNumber].a = labels[indexOfButtonPressed].text!
                
                }}
   }
    }
    
    func objectExist (id: String) -> Bool {
        return realm.object(ofType: Item.self, forPrimaryKey: id)?.t != nil
    }
    
    func save(item: Item){
        do {
            try realm.write{
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    @IBAction func leftArrowPressed(_ sender: UIButton) {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateUIPrevious), userInfo: nil, repeats: false)
       
        
        
    }
    @IBAction func rightArrowPressed(_ sender: UIButton) {
        if numberOfItemsInDataBase < testBrain.questionNumber+1 {
            createAlert(title: "You have to answer the question", message: "")
        } else {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateUINext), userInfo: nil, repeats: false)
        
        }
      
    }
    
    
    
    @objc func updateUIPrevious(){
            self.buttons.forEach { (button) in
            button.setImage(UIImage(named: "buttonTest"), for: .normal)
        }
           
           testBrain.previousQuestion()
           questionLabel.text = testBrain.getQuestionText()
           pageLabel.text = "\(testBrain.questionNumber + 1) of 38"
        
        
           if numberOfItemsInDataBase > testBrain.questionNumber {
                  loadData()
           } else {
    
            self.buttons.forEach { (button) in
            button.setImage(UIImage(named: "buttonTest"), for: .normal)
            }
            
        }
        
        
       }
    
    @objc func updateUINext(){
        self.buttons.forEach { (button) in
        button.setImage(UIImage(named: "buttonTest"), for: .normal)
        }
        testBrain.nextQuestion()
        questionLabel.text = testBrain.getQuestionText()
        pageLabel.text = "\(testBrain.questionNumber + 1) of 38"
     
        if numberOfItemsInDataBase > testBrain.questionNumber {
            print(numberOfItemsInDataBase)
               loadData()
        } else {
            self.buttons.forEach { (button) in
                    button.setImage(UIImage(named: "buttonTest"), for: .normal)
                 }
        }
        
        
    }
    
    func loadData () {
        var n = 0
       items = realm.objects(Item.self)
        let answer = items[testBrain.questionNumber].a
        self.labels.forEach { (label) in
            if let text = label.text {
            if text == answer {
                buttons[n].setImage(UIImage(named: "button_clicked"), for: .normal)
            }
            else {
                
                }
            }
            n+=1
        }
      
    }
    
    func createAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true,completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}


