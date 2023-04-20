//
//  executiveOrderCells.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit

class executiveOrderCells: UITableViewCell {
    //Setup executive order cells
    
    @IBOutlet var number: UILabel!
    @IBOutlet var signed: UILabel!
    @IBOutlet var eoDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
