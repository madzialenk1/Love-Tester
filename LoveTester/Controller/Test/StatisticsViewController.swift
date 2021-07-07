//
//  StatisticsViewController.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 24/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import Foundation
import UIKit
import Charts
import RealmSwift

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var girlfriendDescription: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var profileImage: UIImageView!
    
    let realm = try! Realm()
    var items: List<Item>!
    let typeOfLove: [String] = ["Eros", "Ludus","Storge", "Pragma","Mania","Agape"]
    var pointsForTypeOfLove: [Int] = [0,0,0,0,0,0]
    let desciption = Description()
    var person: Results<Person>!

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let name = defaults.string(forKey: "name")
        person = realm.objects(Person.self).filter("name == %@", name)
        items = person[0].test?.questions
        DispatchQueue.main.async {
            self.addPoints()
            self.updateGraph()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        let barButton = UIBarButtonItem()
        barButton.title = "Menu"
        barButton.target = self
        barButton.action = #selector(comeBackToMenu)
        self.navigationItem.setLeftBarButton(barButton, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        girlfriendDescription.adjustsFontSizeToFitWidth = true
        girlfriendDescription.text = loveDescription(nameOfCharacter: nameOfCharacter(pointsArray: pointsForTypeOfLove))

        changeGender() 
    }
    func changeGender(){
        let defaults = UserDefaults.standard
        guard let gender = defaults.string(forKey: "gender") else {return}
        print(gender)
        
        switch gender {
        case "K": profileImage.image = UIImage(named: "lady")
        case "M": profileImage.image = UIImage(named: "man")
        case "couple": profileImage.image = UIImage(named: "couple_icon")
        default:  break
        }
    }
    
    @objc func comeBackToMenu(){
        
        performSegue(withIdentifier: "toMenu", sender: self)
        
        
      
    }
    func updateGraph(){
        var lineChartEntry  = [ChartDataEntry]()
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: typeOfLove)
        lineChartView.xAxis.granularity = 1
        
        for i in 0..<pointsForTypeOfLove.count {
            let value = ChartDataEntry(x: Double(i), y: Double(pointsForTypeOfLove[i])) //
            lineChartEntry.append(value)
        }
        
        
        let line = LineChartDataSet(entries: lineChartEntry, label: "")
        line.colors = [NSUIColor.blue]
        let data = LineChartData()
        data.addDataSet(line)
        
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        data.setValueFormatter(formatter)
        
        lineChartView.data = data
        lineChartView.chartDescription?.text = "Love Result"
        lineChartView.legend.enabled = false
    }
    
    
    func addPoints(){
        
        for item in items {
            switch (Int(item.numberOfQuestion)!).remainderReportingOverflow(dividingBy: 6) {
            case (5,false):
                pointsForTypeOfLove[0] += points(answer: item.answer)
            case (4,false):
                pointsForTypeOfLove[1] += points(answer: item.answer)
            case (3,false):
                pointsForTypeOfLove[2] += points(answer: item.answer)
            case (1,false):
                pointsForTypeOfLove[4] += points(answer: item.answer)
            case (0,true):
                pointsForTypeOfLove[5] += points(answer: item.answer)
            case (2,false):
                pointsForTypeOfLove[3] += points(answer: item.answer)
            default:
                break
            }
        }
    }
    
    
    func points(answer: String) -> Int {
        
        switch answer {
        case "I totally agree":
            return 5
        case "I agree":
            return 4
        case "I do not know":
            return 3
        case "I disagree":
            return 2
        case "I definitely disagree":
            return 1
        default:
            return 0
        }
    }
    
    func nameOfCharacter(pointsArray: [Int]) -> String {
        
        if let max = pointsArray.max() {
            if max != 0 {
                let index = pointsArray.index(of: max)
                let nameOfCharacter = typeOfLove[index!]
                return nameOfCharacter
            }
        }
        return ""
    }
    
    func loveDescription(nameOfCharacter: String) -> String {
        
        switch (nameOfCharacter) {
        case "Eros":
            return desciption.description[0]
        case "Ludus":
            return desciption.description[1]
        case "Storge":
            return desciption.description[2]
        case "Pragma":
            return desciption.description[3]
        case "Mania":
            return desciption.description[4]
        case "Agape":
            return desciption.description[5]
        default:
            return ""
        }
        
        
        
    }
    
    
    
}














