//
//  BirViewController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/20.
//

import UIKit

class BirViewController: HWPickerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @objc override func cancelAction() {
        self.dismiss(animated: true, completion: nil)

    }
    @objc override func doneAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc override func dataValueChange(_ sender: UIDatePicker) {
        //Date
        let date = sender.date 
        let formatter  = DateFormatter()
        formatter.timeZone = NSTimeZone.init(name: "shanghai") as TimeZone?
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
//        NSString* dateString = [formatter stringFromDate:date];
        let dateStr = formatter.string(from: date)
        
        
        
        print(dateStr)
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
