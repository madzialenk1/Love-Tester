//
//  AdviceViewController.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 15/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class AdviceViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var checked: Results<Person>!
    var checkedArray = List<Bool>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "AdviceCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        try! realm.write{
            checked[0].check?.setValue(checkedArray,forKey: "checked")
        }
        
    }
    
    func initTheTableView(){    
        
        let defaults = UserDefaults.standard
        let name = defaults.string(forKey: "name")
        checked = realm.objects(Person.self).filter("name == %@", name)
        if checked[0].check?.checked.count == 0 {
            for i in advice {
                checkedArray.append(false)
            }
        } else {
            for i in checked[0].check?.checked as! List<Bool> {
                checkedArray.append(i)
            }
        }
    }
}

extension AdviceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return advice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AdviceCell
        cell.adviceLabel.text = advice[indexPath.row].body
        
        if checkedArray[indexPath.row] == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.textLabel?.numberOfLines = 0
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        let backgrounadView = UIView()
        backgrounadView.backgroundColor = .none
        cell.selectedBackgroundView = backgrounadView
        
        return cell
    }
    
}

extension AdviceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if checkedArray[indexPath.row] == true {
            checkedArray[indexPath.row] = false
            
            
        } else {
            checkedArray[indexPath.row] = true
        }
        tableView.reloadData()
        
    }
}

