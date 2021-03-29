//
//  FirstHomeCenterCollectionViewCell.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/16.
//

import UIKit

class FirstHomeCenterCollectionViewCell: UICollectionViewCell {
//    @property (weak, nonatomic) IBOutlet UIView *bottomView;
//    - (void)initUI;
//    - (void)reloadData:(TeacherLectureHallModel*)model;
//    @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *bofangliangLabel;
//    @property (weak, nonatomic) IBOutlet UIImageView *firstVideoImageView;
//    @property (weak, nonatomic) IBOutlet UIImageView *playImageView;
    
    @IBOutlet weak var topBottomView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bofangliangLabel: UILabel!
    @IBOutlet weak var firstVideoImageView: UIImageView!
    @IBOutlet weak var playImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        topBottomView.layer.cornerRadius = 3
    }

}
