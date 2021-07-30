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
    @IBOutlet weak var rightArrowButton: UIButton!
    @IBOutlet weak var leftArrowButton: UIButton!
    
    var testBrain = TestBrain()
    let realm = try! Realm()
    var numberOfItemsInDataBase: Int = 0
    var items = List<Item>()
    var persons: Results<Person>!
    
    
    let defaults = UserDefaults.standard
    var name: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        leftArrowButton.isHidden = true
        questionLabel.text = testBrain.getQuestionText()
        pageLabel.text = "\(testBrain.questionNumber + 1) of 7"
        pageLabel.layer.masksToBounds = true
        pageLabel.layer.cornerRadius = pageLabel.bounds.size.height * 0.3
        questionLabel.adjustsFontSizeToFitWidth = true
        questionLabel.minimumScaleFactor = 0.2
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        checkTheUser()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        defaults.set(numberOfItemsInDataBase, forKey: "count")
    }
    
    func checkTheUser (){
        
        name = defaults.string(forKey: "name")!
        persons = realm.objects(Person.self).filter("name == %@", name)
        if !persons.isEmpty  {
            items = persons[0].test!.questions
            loadData()
        } else {
            addPerson()
            self.buttons.forEach { (button) in
                button.setImage(UIImage(named: "buttonTest"), for: .normal)
            }
            
        }
        if items.isEmpty {
            numberOfItemsInDataBase = 0
        } else {
            numberOfItemsInDataBase = items.count
        }
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
        
        IsTested(sender: sender)
        closeTheTest()
        
    }
    
    func closeTheTest(){
        
        if testBrain.questionNumber == 6 {
            
            createBarButton()
            leftArrowButton.isHidden = true
            if (persons[0].test?.questions.isEmpty)! {
                try! realm.write
                {
                    persons[0].test?.setValue(items, forKey: "questions")
                }
            }
            
        }
    }
    
    func addPerson(){
        
        let person = Person()
        let test = TestCompleted()
        let check = CheckedItems()
        person.name = name
        person.test = test
        person.check = check
        do {
            try realm.write{
                realm.add(person)
            }
        } catch {
            print(error)
        }
        persons = realm.objects(Person.self).filter("name == %@", name)
    }
    
    
    func normalMessage(){
        
        let alert = UIAlertController(title: "Thank you for fulling out the test", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true,completion: nil)
        }
        ))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func createBarButton(){
        let image = UIImage(named: "exit")
        rightArrowButton.setImage(image, for: .normal)
        rightArrowButton.isHidden = false
        
    }
    
    func changer (){
        self.buttons.forEach { (button) in
            button.setImage(UIImage(named: "buttonTest"), for: .normal)
        }
        numberOfItemsInDataBase = 0
        testBrain.questionNumber = 0
        questionLabel.text = testBrain.getQuestionText()
        pageLabel.text = "\(testBrain.questionNumber + 1) of 6"
        rightArrowButton.isHidden = false
    }
    
    func IsTested(sender: UIButton){
        if let indexOfButtonPressed = buttons.firstIndex(of: sender){
            let index = testBrain.questionNumber
            if !objectExist(id: index + 1) {
                let newItem = createNewItem(id: indexOfButtonPressed)
                saveItem(item: newItem, id: index )
                numberOfItemsInDataBase += 1
            }
            else {
                let newItem = createNewItem(id: indexOfButtonPressed)
                try! realm.write {
                    realm.add(newItem, update: .all)
                    
                }
            }
        }
    }
    
    func createNewItem(id: Int) -> Item {
        let newItem = Item()
        let index = testBrain.questionNumber
        newItem.numberOfQuestion = String ("\(index + 1)")
        newItem.answer = labels[id].text!
        newItem.name = "\(name)\(index+1)"
        return newItem
    }
    
    func objectExist (id: Int) -> Bool {
        for item in items {
            if item.name == String("\(name)\(id)"){
                return true
            }
        }
        return false
    }
    
    
    func saveItem(item: Item, id: Int ){
        try! realm.write{
            items.insert(item, at: id)
        }
    }
    
    @IBAction func leftArrowPressed(_ sender: UIButton) {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateUIPrevious), userInfo: nil, repeats: false)
        if testBrain.questionNumber == 6 {
            let image = UIImage(named: "rightArrow")
            rightArrowButton.setImage(image, for: .normal)
        }
    }
    
    @IBAction func rightArrowPressed(_ sender: UIButton) {
        
        
        if testBrain.questionNumber != 6 {
            if numberOfItemsInDataBase < testBrain.questionNumber+1 {
                createAlert(title: "You have to answer the question", message: "")
            } else {
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateUINext), userInfo: nil, repeats: false)
                
            }
        }
        if testBrain.questionNumber == 6 {
            self.performSegue(withIdentifier: "toStatistics", sender: self)
        }
    }
    
    
    
    @objc func updateUIPrevious(){
        self.buttons.forEach { (button) in
            button.setImage(UIImage(named: "buttonTest"), for: .normal)
        }
        
        testBrain.previousQuestion()
        questionLabel.text = testBrain.getQuestionText()
        pageLabel.text = "\(testBrain.questionNumber + 1) of 7"
        
        
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
        
        switch testBrain.questionNumber {
        case 0: leftArrowButton.isHidden = false
        case 5: rightArrowButton.isHidden = true
        default: break
        }
        testBrain.nextQuestion()
        questionLabel.text = testBrain.getQuestionText()
        pageLabel.text = "\(testBrain.questionNumber + 1) of 7"
        
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
        let answer = items[testBrain.questionNumber].answer
        print(answer)
        self.labels.forEach { (label) in
            if let text = label.text {
                if text == answer {
                    buttons[n].setImage(UIImage(named: "button_clicked"), for: .normal)
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




