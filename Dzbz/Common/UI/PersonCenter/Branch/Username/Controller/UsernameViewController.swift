//
//  UsernameViewController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/19.
//

import UIKit

class UsernameViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //MARK: - Life Cycle - 生命周期
    //MARK: - Initalization - 初始化
    //MARK: - SubViews - 子视图
    //MARK: - Button Action - 点击事件
    //MARK: - Utility - 多用途(功能)方法
    //MARK: - Network request - 网络请求


    private  let firstCell = "FirstUsernameTableViewCell"
    private  let firstCellID = "FirstUsernameTableViewCellID"

    @IBOutlet weak var myTableView: UITableView!

    @IBOutlet weak var sureButton: UIButton!
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
        
       
        myTableView.register(UINib(nibName: firstCell, bundle: nil), forCellReuseIdentifier: firstCellID)
        
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            
        let cell:FirstUsernameTableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! FirstUsernameTableViewCell
//            cell.leftLabel.text = titleArray2[indexPath.row]
        cell.nTF.addTarget(self, action: #selector(nTFAction(sender:)), for: .valueChanged)
            
        return cell
        

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        }else if indexPath.section == 1 {
            
        }
    }

    @objc func nTFAction(sender:UITextField) -> Void {
        print(sender.text)
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }

    @IBAction func sureButtonAction(_ sender: Any) {
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
