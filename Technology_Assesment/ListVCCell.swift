//
//  ListVCCell.swift
//  Technology_Assesment
//
//  Created by Haritej on 11/12/20.
//  Copyright © 2020 com.ipac.iOS. All rights reserved.
//

import UIKit

class ListVCCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var abstrct: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var extraLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
