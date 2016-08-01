//
//  JXItemViewController.swift
//  passwordManagement
//
//  Created by jiaxian_he on 16/7/31.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXItemViewController: UIViewController {

    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red()
//        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(button)

        button.layout {
            $0.topAnchor.constraint(equalTo: $0.superview!.topAnchor, constant: 0).activeTrue()
            $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor, constant: 100).activeTrue()
            $0.widthAnchor.constraint(equalToConstant: 100).activeTrue()
            $0.heightAnchor.constraint(equalToConstant: 100).activeTrue()
//            print(make.constraints)
        }

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func tap() {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
