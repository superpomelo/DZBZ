//
//  FileCenterViewController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/16.
//

import UIKit
import QuickLook

class FileCenterViewController: WBQLPreviewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    
    //MARK: - Life Cycle - 生命周期
    //MARK: - Initalization - 初始化
    //MARK: - SubViews - 子视图
    //MARK: - Button Action - 点击事件
    //MARK: - Utility - 多用途(功能)方法
  private  let path = "http://www.gov.cn/zhengce/pdfFile/2021_PDF.pdf"


    
    
    weak  var delegate : SecondHomeCenterTableViewCellDelegate?
    private  let firstCell = "FirstFileCenterCollectionViewCell"
    private  let firstCellID = "FirstFileCenterCollectionViewCellID"
    var dataArray = [String]()
    
    
    @IBOutlet weak var _collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.fd_prefersNavigationBarHidden = true
        
//        let path = Bundle.main.path(forResource:"test_pdf_download", ofType:"pdf")
        
        initcollectionView()

    }
    private func initcollectionView() {
        // Initialization code
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 15, bottom: 0.0, right: 15)
        layout.itemSize = CGSize(width: (SCR_W-40)/4, height: (SCR_W-40)/2+5)
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = false;
        _collectionView.collectionViewLayout = layout;
//        _myCollectionView.register(UINib(nibName: firstCell, bundle: nil), forCellWithReuseIdentifier: firstCellID)
        _collectionView.register(UINib(nibName: firstCell, bundle: nil), forCellWithReuseIdentifier: firstCellID)
        _collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "reusableView")

    
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
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
            lab.attributedText = UILabel.getSystemABTbody("PDF文档", fontInteger: 1, alignment: .left, size: 15, color: label_Color1, lineSpacing: 0)
            header?.addSubview(lab)

        }
        return header!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FirstFileCenterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstFileCenterCollectionViewCellID", for: indexPath) as! FirstFileCenterCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 0.0, left: 15, bottom: 0.0, right: 15)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //判断沙盒路径下是否已下载
        if isFileExist(fileName: path) {
            //直接加载
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            //新文件名
            let newName = path.split(separator: "/").last!.description
            let fileURL = documentsURL.appendingPathComponent(newName)
            self.fileURL = fileURL
            self.handlePLPreviewDataSource()
            
        }else{
            //去下载
            requestDownLoad()
        }
    }

    //MARK: - Network request - 网络请求

    
    public  func isFileExist(fileName:String) -> Bool {
         let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
         //新文件名
         let newName = fileName.split(separator: "/").last!.description
         let fileURL = documentsURL.appendingPathComponent(newName)
         let fileManager = FileManager.default
        //注意-此处比较fileURL.path 而不是 fileURL.absoluteString<字符串>
         let bol = fileManager.fileExists(atPath: fileURL.path)
       
         return bol
     }
    /**下载*/
    func requestDownLoad() -> Void {

        BaseRequestDatas().RequestWithDownLoad(isToken: false, pathurl: path) { (result) in
            if Thread.isMainThread {
                //code
                self.fileURL = result as! URL
                self.handlePLPreviewDataSource()
            } else {
                DispatchQueue.main.async {
                    //code
                    self.fileURL = result as! URL
                    self.handlePLPreviewDataSource()
                }
            }

        } failure: { (error) in
            
        }
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
