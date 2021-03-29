//
//  SecondHomeCenterTableViewCell.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/16.
//

import UIKit
protocol SecondHomeCenterTableViewCellDelegate:NSObjectProtocol {
    func CellCollectionAction(cell:SecondHomeCenterTableViewCell,indexPath:NSIndexPath)

}
class SecondHomeCenterTableViewCell: UITableViewCell,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    weak  var delegate : SecondHomeCenterTableViewCellDelegate?
//    private  let firstCell = "FirstHomeCenterCollectionViewCell"
//    private  let firstCellID = "FirstHomeCenterCollectionViewCellID"
    var dataArray = [String]()
    
    
    @IBOutlet weak var _collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 15, bottom: 0.0, right: 15)
        layout.itemSize = CGSize(width: (SCR_W-40)/2, height: (SCR_W-40)/2+5)
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = false;
        _collectionView.collectionViewLayout = layout;
//        _myCollectionView.register(UINib(nibName: firstCell, bundle: nil), forCellWithReuseIdentifier: firstCellID)
        _collectionView.register(UINib(nibName: "FirstHomeCenterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FirstHomeCenterCollectionViewCellID")
        _collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "reusableView")

        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    //组头高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCR_W, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header:UICollectionReusableView? = nil
        if kind == UICollectionView.elementKindSectionHeader {
            header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "reusableView", for: indexPath)
            //此处header可能会产生复用，所以在使用之前将其子视图移除掉

            for  vi in header!.subviews {
                vi.removeFromSuperview()
            }
            let lab = UILabel.init(frame: CGRect(x: 20, y: 25, width: SCR_W-150, height: 15))
            lab.attributedText = UILabel.getSystemABTbody("最新动捕数据", fontInteger: 1, alignment: .left, size: 15, color: label_Color1, lineSpacing: 0)
            
           
            header?.addSubview(lab)

        }
        return header!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FirstHomeCenterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstHomeCenterCollectionViewCellID", for: indexPath) as! FirstHomeCenterCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 0.0, left: 15, bottom: 0.0, right: 15)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.CellCollectionAction(cell: self, indexPath: indexPath as NSIndexPath)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
