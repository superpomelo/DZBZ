//
//  TabBarViewController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/16.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

        initView()
        
        self.tabBar.tintColor = Hex_Color(0x409EFE,1)

    }
       
    private func initView () {
        let titles = ["动捕数据","舞蹈视频","资源文档", "个人中心"]
        let images =  ["动捕数据","舞蹈视频","资源文档", "个人中心"]
        let selectedImages =  ["动捕数据1","舞蹈视频1","资源文档1", "个人中心1"]
        let oneVC = HomeCenterViewController()
        let twoVC = DanceCenterViewController()
        let threeVC = FileCenterViewController()
        let fourVC = PersonCenterViewController()
        let viewControllers = [oneVC,twoVC,threeVC, fourVC]

        for i in 0...(viewControllers.count)-1 {
           setVC(vc: viewControllers[i], title: titles[i], image: images[i], selectedImage: selectedImages[i])
        }
        
    }

    private func setVC(vc:UIViewController,title:String,image:String,selectedImage:String) -> Void {
        vc.tabBarItem.title = title
        var dict = [NSAttributedString.Key:Any]()
        dict[kCTFontAttributeName as NSAttributedString.Key] = UIFont.systemFont(ofSize: 10);
        vc.tabBarItem.setTitleTextAttributes(dict, for: .normal)
        vc.tabBarItem.image = UIImage.init(named: image)
        vc.tabBarItem.selectedImage = UIImage.init(named: selectedImage)
        self.addChild(UINavigationController.init(rootViewController: vc))

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
