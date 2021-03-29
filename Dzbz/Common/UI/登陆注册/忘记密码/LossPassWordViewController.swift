//
//  LossPassWordViewController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/18.
//

import UIKit

class LossPassWordViewController: UIViewController {
    @IBOutlet weak var acTF: UITextField!
    @IBOutlet weak var psTF: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
        self.fd_prefersNavigationBarHidden = true

    }
    private  func initUI() -> Void {
        loginButton.layer.cornerRadius = 5
        loginButton.backgroundColor = seDiao_Color1
    }
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        regLost()
    }
    
    /**忘记密码*/
    private  func regLost() -> Void {
        var para = [String:String]()
        para["oldPwd"] = acTF.text
        para["newPwd"] = psTF.text
        LoginAndRRequestDatas().RequestWithLost(parameters: para) { (result) in
//            let mo:registerModel = result as! registerModel
//            print(mo.birthday)
//            self.navigationController?.popViewController(animated: true)
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
