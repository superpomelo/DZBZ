//
//  InfoViewController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/18.
//

import UIKit

class InfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //MARK: - Life Cycle - 生命周期
    //MARK: - Initalization - 初始化
    //MARK: - SubViews - 子视图
    //MARK: - Button Action - 点击事件
    //MARK: - Utility - 多用途(功能)方法
    //MARK: - Network request - 网络请求
    let titleArray1 = ["用户名"]
    let titleArray2 = ["生日"]

    private  let firstCell = "FirstInfoViewTableViewCell"
    private  let firstCellID = "FirstInfoViewTableViewCellID"
    private  let secondCell = "SecondInfoViewTableViewCell"
    private  let secondCellID = "SecondInfoViewTableViewCellID"
    @IBOutlet weak var myTableView: UITableView!
    private   var model : PersonCenterModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initMyTableView()
        self.fd_prefersNavigationBarHidden = true

    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) {
            self.get_user_info()
        }
    }
    /**初始化tableview*/
    private func initMyTableView() {
         
        myTableView.delegate   = self
         
        myTableView.dataSource = self
        
        myTableView.bounces = false
//        myTableView.rowHeight = 200
        
       
        myTableView.register(UINib(nibName: firstCell, bundle: nil), forCellReuseIdentifier: firstCellID)
        myTableView.register(UINib(nibName: secondCell, bundle: nil), forCellReuseIdentifier: secondCellID)
        myTableView.tableFooterView = UIView.init()

     }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==0 {
            return 15
        }
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        let v = UIView.init(frame: CGRect(x: 0, y: 0, width: SCR_W, height: 10))
        v.backgroundColor = RGB_Color(245,245,245,1)
        return v
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return 55
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return titleArray1.count
        }else{
            return titleArray2.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        if indexPath.section == 0 {
            
            let cell:FirstInfoViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! FirstInfoViewTableViewCell
//            cell.leftLabel.text = titleArray1[indexPath.row]
            
            return cell
        }else if indexPath.section == 1 {
            let cell:SecondInfoViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: secondCellID, for: indexPath) as! SecondInfoViewTableViewCell
            cell.leftLabel.text = titleArray1[indexPath.row]
            if model != nil {
                cell.reloadData(str: model!.userName)
            }
            
            return cell
        }else{
            let cell:SecondInfoViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: secondCellID, for: indexPath) as! SecondInfoViewTableViewCell
            cell.leftLabel.text = titleArray2[indexPath.row]
            if model != nil {
                cell.reloadData(str: model!.birthday)
            }
            return cell
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {

        }else if indexPath.section == 1 {
            self.present(UsernameViewController(), animated: true) {
                
            }
        }else if indexPath.section == 2 {
            self.presentPanModal(BirViewController())

        }
    }

    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    /**获取个人信息*/
    private  func get_user_info() -> Void {
       
        PersonalRequestData().RequestWithget_user_info(parameters: nil) { [self] (result) in
//            let mo:registerModel = result as! registerModel
//            print(mo.birthday)
//            self.navigationController?.popViewController(animated: true)

            self.model = result as! PersonCenterModel
            myTableView.reloadData()
            
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
