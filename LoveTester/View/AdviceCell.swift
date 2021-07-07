//
//  AdviceCell.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 06/12/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//

import UIKit

class AdviceCell: UITableViewCell {
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var adviceView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        adviceView.layer.cornerRadius = 15
      //  adviceLabel.adjustsFontForContentSizeCategory = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
