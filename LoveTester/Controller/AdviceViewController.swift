//
//  AdviceViewController.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 15/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import Foundation
import UIKit
class AdviceViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var advice: [AdviceItem] = [
        AdviceItem(body: "Be yourself"),
        AdviceItem(body: "Buy Flowers"),
        AdviceItem(body: "Make a surprise"),
        AdviceItem(body: "Don’t stay with someone who antagonizes you or belittles you."),
        AdviceItem(body: "Love is a verb, not a noun."),
        AdviceItem(body: "Don’t settle for someone who has zero regard for your feelings or wants just because you’ve been together a long time."),
        AdviceItem(body: "No relationship is perfect and there will be conflict. What matters is the desire to solve the problem."),
        AdviceItem(body: "Don’t disparage your SO behind their back."),
        AdviceItem(body: "Confidence isn’t “I know she likes me”, confidence is “I’ll be okay whether she likes me or not.”")
        
    ]
    
    

override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
   
}
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    tableView.estimatedRowHeight = 500
    tableView.rowHeight = UITableView.automaticDimension
    
                  
}
}

extension AdviceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return advice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = advice[indexPath.row].body
        cell.textLabel?.numberOfLines = 0
        return cell
    }
 
 
    
    
}

extension AdviceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
         
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
}

