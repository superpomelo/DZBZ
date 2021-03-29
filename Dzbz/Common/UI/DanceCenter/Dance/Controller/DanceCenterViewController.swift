//
//  DanceCenterViewController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/16.
//

import UIKit
import QuickLook

class DanceCenterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    //MARK: - Life Cycle - 生命周期
    //MARK: - Initalization - 初始化
    //MARK: - SubViews - 子视图
    //MARK: - Button Action - 点击事件
    //MARK: - Utility - 多用途(功能)方法
    //MARK: - Network request - 网络请求
    @IBOutlet weak var topView: UIView!
//    @IBOutlet weak var myTableView: UITableView!
    /**scrollerview2的父视图*/
    @IBOutlet weak var tabBottomView: UIView!
    private var btnAry = [UIButton]()
    private var lineView = UIView()

    private var lastbtn = UIButton()
    private let scrView1 = UIScrollView()
    private var scrView2 = UIScrollView()
    private let titleArray = ["首页","古典","民族","芭蕾","现代","当代"];
    private  let firstCell = "FirstHomeCenterTableViewCell"
    private  let firstCellID = "FirstHomeCenterTableViewCellID"
    private  let secondCell = "SecondHomeCenterTableViewCell"
    private  let secondCellID = "SecondHomeCenterTableViewCellID"
    //MARK: - Life Cycle - 生命周期

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initscrollerView()

        initscrollerView2()
//        initMyTableView()
         
        self.fd_prefersNavigationBarHidden = true
    }
//    override func viewWillAppear(_ animated: Bool) {
       
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//            for btn:UIButton in self.btnAry {
//                if btn.isSelected {
//                    self.lineView1.center.x = btn.center.x
//                }
//            }
//
//        }
//    }
    //MARK: - Initalization - 初始化

    private  func initscrollerView() -> Void {
        scrView1.frame = self.topView.bounds
//        scrView1.contentSize = CGSize(width: 85*titleArray.count+70, height: 35)
        scrView1.contentSize = CGSize(width: SCR_W, height: 35)

        //  水平
        scrView1.showsHorizontalScrollIndicator = false
         // 垂直
        scrView1.showsVerticalScrollIndicator = false
        for i in 0...titleArray.count-1 {
            
//            let btn = UIButton.init(frame: CGRect(x: 15+85*i, y: 1, width: 85, height: 33))
            let btn = UIButton.init(frame: CGRect(x: Int(SCR_W)/titleArray.count*i, y: 1, width: Int(SCR_W)/titleArray.count, height: 33))

            btn.setAttributedTitle(UIButton.getSystemABTbody(titleArray[i], fontInteger: 1, size: 15, color: .black, lineSpacing: 0), for: .normal)
            btn.setAttributedTitle(UIButton.getSystemABTbody(titleArray[i], fontInteger: 1, size: 15, color: seDiao_Color1, lineSpacing: 0), for: .selected)
            btn.addTarget(self, action: #selector(btnAction(sender:)), for: .touchUpInside)
            btn.tag = 720+i
            if i == 0 {
                btn.isSelected = true
                lastbtn = btn
            }
            btnAry.append(btn)
            scrView1.addSubview(btn)
        }
        topView.addSubview(scrView1)
        
        let btn:UIButton = btnAry[0]
        self.topView.addSubview(self.lineView1)
        lineView = self.lineView1
        self.lineView1.mas_makeConstraints { (make) in
            make?.bottom.mas_equalTo()(self.topView)?.offset()(0)
            make?.centerX.mas_equalTo()(btn)?.offset()(0)
            make?.width.mas_equalTo()(35)
            make?.height.mas_equalTo()(2)


        }
    }
    
    @objc func btnAction(sender:UIButton) {
        if lastbtn == sender {
            return
        }
        
        lineView.center.x = sender.center.x
        sender.isSelected = true
        lastbtn.isSelected = false
        if sender.tag == 720 {
            scrView2.contentOffset.x = 0
        }else if sender.tag == 721 {
            scrView2.contentOffset.x = SCR_W

        }else if sender.tag == 722 {
            scrView2.contentOffset.x = SCR_W*2

        }else if sender.tag == 723 {
            scrView2.contentOffset.x = SCR_W*3

        }else if sender.tag == 724 {
            scrView2.contentOffset.x = SCR_W*4

        }else if sender.tag == 725 {
            scrView2.contentOffset.x = SCR_W*5

        }
        
        lastbtn = sender
    }
    
    private  func initscrollerView2() -> Void {
        
        scrView2.frame = self.tabBottomView.bounds
        let h = self.tabBottomView.bounds.size.height
        
        scrView2.contentSize = CGSize(width: Int(SCR_W)*titleArray.count, height: Int(h))

        //  水平
        scrView2.showsHorizontalScrollIndicator = true
         // 垂直
        scrView2.showsVerticalScrollIndicator = false
        scrView2.isUserInteractionEnabled = true
        scrView2.isPagingEnabled = true
        scrView2.delegate = self
        for i in 0...titleArray.count-1 {
            if i == 0 {
                self.tableView1.frame = CGRect(x: Int(SCR_W)*i, y: 0, width: Int(SCR_W), height: Int(h))
                scrView2.addSubview(tableView1)
            }else if i == 1{
                self.tableView2.frame = CGRect(x: Int(SCR_W)*i, y: 0, width: Int(SCR_W), height: Int(h))
                scrView2.addSubview(tableView2)

            }else if i == 2{
                self.tableView3.frame = CGRect(x: Int(SCR_W)*i, y: 0, width: Int(SCR_W), height: Int(h))
                scrView2.addSubview(tableView3)

            }else if i == 3{
                self.tableView4.frame = CGRect(x: Int(SCR_W)*i, y: 0, width: Int(SCR_W), height: Int(h))
                scrView2.addSubview(tableView4)
                
            }else if i == 4{
                self.tableView5.frame = CGRect(x: Int(SCR_W)*i, y: 0, width: Int(SCR_W), height: Int(h))
                scrView2.addSubview(tableView5)
            }else if i == 5{
                self.tableView6.frame = CGRect(x: Int(SCR_W)*i, y: 0, width: Int(SCR_W), height: Int(h))
                scrView2.addSubview(tableView6)
            }
    
        }
        tabBottomView.addSubview(scrView2)
    }
    private lazy var lineView1: UIView = {
        
        let lineView1 = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 2))
        lineView1.layer.cornerRadius = 2
        lineView1.backgroundColor = seDiao_Color1
        
        return lineView1
    }()
    private lazy var tableView1: UITableView = {
        
//        let tableView1 = UITableView(frame: CGRect.zero, style: .plain)
        let tableView1 = UITableView()
        tableView1.dataSource = self
        tableView1.delegate = self
        
        tableView1.separatorStyle = .none
        tableView1.showsVerticalScrollIndicator = false
        tableView1.tag = 700

        tableView1.rowHeight = 65
        tableView1.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        tableView1.register(UINib(nibName: firstCell, bundle: nil), forCellReuseIdentifier: firstCellID)
        tableView1.register(UINib(nibName: secondCell, bundle: nil), forCellReuseIdentifier: secondCellID)
        return tableView1
    }()
    private lazy var tableView2: UITableView = {
        
//        let tableView1 = UITableView(frame: CGRect.zero, style: .plain)
        let tableView2 = UITableView()
        tableView2.dataSource = self
        tableView2.delegate = self
        tableView2.tag = 701

        tableView2.separatorStyle = .none
        tableView2.showsVerticalScrollIndicator = false
        
        tableView2.rowHeight = 65
        tableView2.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        tableView2.register(UINib(nibName: firstCell, bundle: nil), forCellReuseIdentifier: firstCellID)
        tableView2.register(UINib(nibName: secondCell, bundle: nil), forCellReuseIdentifier: secondCellID)
        return tableView2
    }()
    private lazy var tableView3: UITableView = {
        
//        let tableView1 = UITableView(frame: CGRect.zero, style: .plain)
        let tableView3 = UITableView()
        tableView3.dataSource = self
        tableView3.delegate = self
        tableView3.tag = 702

        tableView3.separatorStyle = .none
        tableView3.showsVerticalScrollIndicator = false
        
        tableView3.rowHeight = 65
        tableView3.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        tableView3.register(UINib(nibName: firstCell, bundle: nil), forCellReuseIdentifier: firstCellID)
        tableView3.register(UINib(nibName: secondCell, bundle: nil), forCellReuseIdentifier: secondCellID)
        return tableView3
    }()
    
    private lazy var tableView4: UITableView = {
        
//        let tableView1 = UITableView(frame: CGRect.zero, style: .plain)
        let tableView4 = UITableView()
        tableView4.dataSource = self
        tableView4.delegate = self
        tableView4.tag = 703

        tableView4.separatorStyle = .none
        tableView4.showsVerticalScrollIndicator = false
        
        tableView4.rowHeight = 65
        tableView4.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        tableView4.register(UINib(nibName: firstCell, bundle: nil), forCellReuseIdentifier: firstCellID)
        tableView4.register(UINib(nibName: secondCell, bundle: nil), forCellReuseIdentifier: secondCellID)
        return tableView4
    }()
    
    private lazy var tableView5: UITableView = {
        
//        let tableView1 = UITableView(frame: CGRect.zero, style: .plain)
        let tableView5 = UITableView()
        tableView5.dataSource = self
        tableView5.delegate = self
        tableView5.tag = 704

        tableView5.separatorStyle = .none
        tableView5.showsVerticalScrollIndicator = false
        
        tableView5.rowHeight = 65
        tableView5.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        tableView5.register(UINib(nibName: firstCell, bundle: nil), forCellReuseIdentifier: firstCellID)
        tableView5.register(UINib(nibName: secondCell, bundle: nil), forCellReuseIdentifier: secondCellID)
        return tableView5
    }()
    
    private lazy var tableView6: UITableView = {
        
//        let tableView1 = UITableView(frame: CGRect.zero, style: .plain)
        let tableView6 = UITableView()
        tableView6.dataSource = self
        tableView6.delegate = self
        tableView6.tag = 705

        tableView6.separatorStyle = .none
        tableView6.showsVerticalScrollIndicator = false
        
        tableView6.rowHeight = 65
        tableView6.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        tableView6.register(UINib(nibName: firstCell, bundle: nil), forCellReuseIdentifier: firstCellID)
        tableView6.register(UINib(nibName: secondCell, bundle: nil), forCellReuseIdentifier: secondCellID)
        return tableView6
    }()
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        }else{
            let array = ["","","","","","","",""]
            
            if (array.count%2 == 0) {
//                return ((SCR_W-40)/2+5)*array.count/2+(array.count/2*10)
                
                let row_h1 = SCR_W-40
                let row_h2 = row_h1/2+5
                let row_h3 = Int(row_h2)*array.count/2
                
                let row_h4 = array.count/2*10

                return CGFloat(row_h3 + row_h4 + 55)
            }else{
//                return ((SCR_W-40)/2+5)*(array.count+1)/2+((array.count+1)/2*10)
                return 20
            }
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell:FirstHomeCenterTableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! FirstHomeCenterTableViewCell
            return cell
        }else{
            let cell:SecondHomeCenterTableViewCell = tableView.dequeueReusableCell(withIdentifier: secondCellID, for: indexPath) as! SecondHomeCenterTableViewCell
            
            
            return cell
        }

    }
    //MARK: - SubViews - 子视图
    //MARK: - Button Action - 点击事件

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(SCR_W)
        print(scrView2.contentOffset.x)
        if scrView2.isDragging == true {
            if scrView2.contentOffset.x >= 0 && scrView2.contentOffset.x < SCR_W/2 {
//                let btn:UIButton = view.viewWithTag(620) as! UIButton
                let btn:UIButton = btnAry[0]

                if lastbtn == btn {
                    return
                }
                UIView.animate(withDuration: 0.3) {
                    self.lineView.center.x = btn.center.x
                }

    //            scrView1.contentOffset.x = 0
                btn.isSelected = true
                lastbtn.isSelected = false
                lastbtn = btn
                
            }else if scrView2.contentOffset.x >= SCR_W/2 && scrView2.contentOffset.x < SCR_W*2-SCR_W/2 {
//                let btn:UIButton = view.viewWithTag(621) as! UIButton
                let btn:UIButton = btnAry[1]

                if lastbtn == btn {
                    return
                }
                UIView.animate(withDuration: 0.3) {
                    self.lineView.center.x = btn.center.x
                }
    //            scrView1.contentOffset.x = 0
                btn.isSelected = true
                lastbtn.isSelected = false
                lastbtn = btn
                print("11111")

            }else if scrView2.contentOffset.x >= SCR_W*2-SCR_W/2 && scrView2.contentOffset.x < SCR_W*3-SCR_W/2 {
//                let btn:UIButton = view.viewWithTag(622) as! UIButton
                let btn:UIButton = btnAry[2]

                if lastbtn == btn {
                    return
                }
                UIView.animate(withDuration: 0.3) {
                    self.lineView.center.x = btn.center.x
                }

    //            scrView1.contentOffset.x = 0
                btn.isSelected = true
                lastbtn.isSelected = false
                lastbtn = btn
                print("22222")


            }else if scrView2.contentOffset.x >= SCR_W*3-SCR_W/2 && scrView2.contentOffset.x < SCR_W*4-SCR_W/2 {

//                let btn:UIButton = view.viewWithTag(623) as! UIButton
                let btn:UIButton = btnAry[3]


                if lastbtn == btn {

                    return

                }
                UIView.animate(withDuration: 0.3) {
                    self.lineView.center.x = btn.center.x
                }
    //            scrView1.contentOffset.x = CGFloat(Int(SCR_W)/titleArray.count*3)
                btn.isSelected = true

                lastbtn.isSelected = false



                lastbtn = btn

                print("33333")

            }else if scrView2.contentOffset.x >= SCR_W*4-SCR_W/2 && scrView2.contentOffset.x < SCR_W*5-SCR_W/2 {

//                let btn:UIButton = view.viewWithTag(624) as! UIButton
                let btn:UIButton = btnAry[4]

                if lastbtn == btn {

                    return

                }
                UIView.animate(withDuration: 0.3) {
                    self.lineView.center.x = btn.center.x
                }

    //            scrView1.contentOffset.x = CGFloat(Int(SCR_W)/titleArray.count*3)
                btn.isSelected = true

                lastbtn.isSelected = false


                lastbtn = btn

                print("44444")

            }else if scrView2.contentOffset.x >= SCR_W*5-SCR_W/2 && scrView2.contentOffset.x < SCR_W*6-SCR_W/2  {
                let btn:UIButton = btnAry[5]
//                let btn:UIButton = view.viewWithTag(625) as! UIButton

                if lastbtn == btn {

                    return

                }
                UIView.animate(withDuration: 0.3) {
                    self.lineView.center.x = btn.center.x
                }

    //            scrView1.contentOffset.x = CGFloat(Int(SCR_W)/titleArray.count*3)
                btn.isSelected = true

                lastbtn.isSelected = false


                lastbtn = btn

                print("55555")

            }
        }

    }
    //MARK: - Utility - 多用途(功能)方法
    //MARK: - Network request - 网络请求

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
