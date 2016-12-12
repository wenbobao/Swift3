//
//  BookCell.swift
//  LearnSwiftLanguage
//
//  Created by bob on 16/12/12.
//  Copyright © 2016年 bob. All rights reserved.
//

import UIKit

class BookTitleCell: UITableViewCell {

    @IBOutlet weak var bookNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
