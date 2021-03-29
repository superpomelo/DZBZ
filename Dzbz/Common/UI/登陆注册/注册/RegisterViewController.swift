//
//  RegisterViewController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/16.
//

import UIKit

class RegisterViewController: UIViewController {
    /**学号/邀请码tf*/
//    @property (weak, nonatomic) IBOutlet UITextField *xueHaoAndInvitationTextField;
//
//    /**注册*/
//    @property (weak, nonatomic) IBOutlet UIButton *registerButton;
//    /**学号*/
//    @property (weak, nonatomic) IBOutlet UIButton *xueHaoButton;
//    /**邀请码*/
//    @property (weak, nonatomic) IBOutlet UIButton *invitationCodeButton;
//    /**学号-邀请码联动线*/
//    @property (weak, nonatomic) IBOutlet UILabel *lianDongLine;
//    /**发送验证码底部view*/
//    @property (weak, nonatomic) IBOutlet UIView *sendCodeButtomView;
//    /**重新获取/获取验证码*/
//    @property (weak, nonatomic) IBOutlet UILabel *getCodeLabel;
//    /**（ */
//    @property (weak, nonatomic) IBOutlet UILabel *leftKLabel;
//    /**秒数*/
//    @property (weak, nonatomic) IBOutlet UILabel *secondsLabel;
//    /** ）*/
//    @property (weak, nonatomic) IBOutlet UILabel *rightKLabel;
//    /**获取验证码*/
//    @property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
//
//    @property (nonatomic,weak)NSTimer *registertimer;
//    @property (nonatomic,assign )int TAG;
//    @property (weak, nonatomic) IBOutlet UITextField *zhangHaoTF;
//    @property (weak, nonatomic) IBOutlet UITextField *codeTF;
//    @property (weak, nonatomic) IBOutlet UITextField *passWordTF;
//    @property (nonatomic,assign )int tagT;
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var sendCodeButtomView: UIView!
    @IBOutlet weak var getCodeLabel: UILabel!
    @IBOutlet weak var leftKLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var rightKLabel: UILabel!
    @IBOutlet weak var getCodeButton: UIButton!
    @IBOutlet weak var zhangHaoTF: UITextField!
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var passWordTF: UITextField!
    //MARK: - Life Cycle - 生命周期

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
        self.fd_prefersNavigationBarHidden = true

    }
    //MARK: - Initalization - 初始化
  
    private  func initUI() -> Void {
        registerButton.layer.cornerRadius = 5
        registerButton.backgroundColor = seDiao_Color1
    }
    
    //MARK: - SubViews - 子视图
    //MARK: - Button Action - 点击事件

    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendCodeButtonAction(_ sender: Any) {
    }
    
    @IBAction func regButtonAction(_ sender: Any) {
        regRequest()
    }
    //MARK: - Utility - 多用途(功能)方法
    //MARK: - Network request - 网络请求
    /**注册*/
    private  func regRequest() -> Void {
        var para = [String:String]()
        para["phoneNumber"] = zhangHaoTF.text
        para["pwd"] = passWordTF.text
//        var resultDic = [String: Any]()
//        resultDic["body"] = "phoneNumber=16870714471&pwd=12345"
        LoginAndRRequestDatas().RequestWithResign(parameters: para) { (result) in
            let mo:registerModel = result as! registerModel
            print(mo.birthday)
            self.navigationController?.popViewController(animated: true)
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
