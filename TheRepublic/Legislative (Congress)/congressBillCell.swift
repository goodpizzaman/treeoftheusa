//
//  congressBillCell.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit

class congressBillCell: UITableViewCell {
    //Setup congress bill cells
    
    @IBOutlet var yesNoBG: UIImageView!
    @IBOutlet var billNumber: UILabel!
    @IBOutlet var rollCallNumber: UILabel!
    @IBOutlet var billTitle: UILabel!
    @IBOutlet var passedFailed: UILabel!
    @IBOutlet var votedDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
