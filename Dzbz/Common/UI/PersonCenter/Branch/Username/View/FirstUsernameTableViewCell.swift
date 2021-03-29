//
//  FirstUsernameTableViewCell.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/19.
//

import UIKit

class FirstUsernameTableViewCell: UITableViewCell {

    @IBOutlet weak var nTF: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nTF.becomeFirstResponder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
