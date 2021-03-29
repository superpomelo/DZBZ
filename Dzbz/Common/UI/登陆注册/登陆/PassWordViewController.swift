//
//  PassWordViewController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/16.
//

import UIKit

class PassWordViewController: UIViewController {

    @IBOutlet weak var acTF: UITextField!
    @IBOutlet weak var psTF: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var closeImageView: UIImageView!
    /**用户协议和隐私政策控件*/
    @IBOutlet weak var tvAgree: UITextView!
   
    @IBOutlet weak var lostButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        acTF.text = "15070078552"
        psTF.text = "123"
        initUI()
        self.fd_prefersNavigationBarHidden = true

    }
    private  func initUI() -> Void {
        lostButton.isHidden = true
        loginButton.layer.cornerRadius = 5
        loginButton.backgroundColor = seDiao_Color1
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
    }
    
    @IBAction func lostButtonAction(_ sender: Any) {
        navigationController?.pushViewController(LossPassWordViewController(), animated: true)

    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        UIApplication.shared.keyWindow?.endEditing(true)
//        logRequest()
        SwitchRootController().goHomeViewController()


    }
    
    
    /**登陆*/
    private  func logRequest() -> Void {
        var para = [String:String]()
        para["userName"] = acTF.text
        para["pwd"] = psTF.text
//        var resultDic = [String: Any]()
//        resultDic["body"] = "phoneNumber=16870714471&pwd=12345"
        LoginAndRRequestDatas().RequestWithLogin(parameters: para) { (result) in
            let mo:passWordLoginModel = result as! passWordLoginModel
            print(mo.birthday)
            UserInfoManager.setToken(mo.token)
            UserInfoManager.setUid(mo.userId)

            SwitchRootController().goHomeViewController()

        } failure: { (error) in
            self.presentPanModal(HWTransientAlertViewController())

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
