//
//  theConstitutionCells.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit

class theConstitutionCells: UITableViewCell {
    //cell for 'theConstitution' tableview
    
    //Label for name of article or ammendment
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
