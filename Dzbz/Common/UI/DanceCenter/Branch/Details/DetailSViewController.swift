//
//  DetailSViewController.swift
//  SwiftBaseAppBao
//
//  Created by 狍子 on 2021/3/24.
//

import UIKit

class DetailSViewController: DetailViewController {
    @IBOutlet weak var playBottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fd_prefersNavigationBarHidden = true
        self.wmPlayer.frame = playBottomView.bounds
        playBottomView.addSubview(wmPlayer)
        wmPlayer.play()
        // Do any additional setup after loading the view.
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
