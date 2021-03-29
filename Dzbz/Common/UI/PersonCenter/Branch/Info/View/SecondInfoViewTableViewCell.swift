//
//  SecondInfoViewTableViewCell.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/19.
//

import UIKit

class SecondInfoViewTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reloadData(str:String) {
        rightLabel.text = str
    }
  
}
