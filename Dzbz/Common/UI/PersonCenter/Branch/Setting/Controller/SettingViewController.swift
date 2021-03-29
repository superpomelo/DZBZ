//
//  SettingViewController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/18.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //MARK: - Life Cycle - 生命周期
    //MARK: - Initalization - 初始化
    //MARK: - SubViews - 子视图
    //MARK: - Button Action - 点击事件
    //MARK: - Utility - 多用途(功能)方法
    //MARK: - Network request - 网络请求
    let titleArray1 = ["修改密码"]
    let titleArray2 = ["退出"]

    private  let firstCell = "FirstPersonCenterTableViewCell"
    private  let firstCellID = "FirstPersonCenterTableViewCellID"
    private  let secondCell = "SecondPersonCenterTableViewCell"
    private  let secondCellID = "SecondPersonCenterTableViewCellID"
    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initMyTableView()
        self.fd_prefersNavigationBarHidden = true

    }

    /**初始化tableview*/
    private func initMyTableView() {
         
        myTableView.delegate   = self
         
        myTableView.dataSource = self
        
        myTableView.bounces = false
//        myTableView.rowHeight = 200
        
       
        
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if section == 0 {
            return titleArray1.count
        }else{
            return titleArray2.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        if indexPath.section == 0 {
            let cell:SecondPersonCenterTableViewCell = tableView.dequeueReusableCell(withIdentifier: secondCellID, for: indexPath) as! SecondPersonCenterTableViewCell
            cell.leftLabel.text = titleArray1[indexPath.row]

            
            return cell
        }else{
            let cell:SecondPersonCenterTableViewCell = tableView.dequeueReusableCell(withIdentifier: secondCellID, for: indexPath) as! SecondPersonCenterTableViewCell
            cell.leftLabel.text = titleArray2[indexPath.row]
            
            return cell
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            navigationController?.pushViewController(LossPassWordViewController(), animated: true)
        }else if indexPath.section == 1 {
            tips()
        }
    }
    
   
    private func tips() -> Void {
        let alertVC = UIAlertController(title: "提示", message: "确定退出登录", preferredStyle: UIAlertController.Style.alert)
        let acSure = UIAlertAction(title: "确定", style: UIAlertAction.Style.destructive) { (UIAlertAction) -> Void in
                   print("click Sure")
           
            self.ExitRequest()

               }
        let acCancel = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel) { (UIAlertAction) -> Void in
                   print("click Cancel")
               }
               alertVC.addAction(acSure)
               alertVC.addAction(acCancel)
        self.present(alertVC, animated: true, completion: nil)
    }
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

    /**推出登陆*/
    private  func ExitRequest() -> Void {
//        var para = [String:String]()
//        para["userName"] = acTF.text
//        para["pwd"] = psTF.text
//        var resultDic = [String: Any]()
//        resultDic["body"] = "phoneNumber=16870714471&pwd=12345"
        LoginAndRRequestDatas().RequestWithExit(parameters: nil) { (result) in
            UserInfoManager.removeAllValue()

            SwitchRootController().goLoginController()

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
