//
//  CustomDataSessionTableViewCell.swift
//  MyExampleMaps
//
//  Created by Kirill on 16.02.17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

class CustomDataSessionTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var valueLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
