//
//  FirstFileCenterCollectionViewCell.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/26.
//

import UIKit

class FirstFileCenterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.attributedText = UILabel.getSystemABTbody("测试文档", fontInteger: 1, alignment: .center, size: 10, color: label_Color1, lineSpacing: 0)
            
        
    }

}
