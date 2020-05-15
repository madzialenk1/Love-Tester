//
//  popUp.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 15/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//


import UIKit
class PopUp: UIView {
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("Coś poszlo nie tak")
    }
}
