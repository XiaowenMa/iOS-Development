//
//  StartPageViewController.swift
//  XiaowenMa-Lab4
//
//  Created by 马晓雯 on 7/13/20.
//  Copyright © 2020 Xiaowen Ma. All rights reserved.
//

import UIKit

class StartPageViewController: UIViewController {

    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        logIn.layer.cornerRadius=15;
        logIn.layer.backgroundColor=UIColor.systemGray6.cgColor
        signUp.layer.cornerRadius=15;
        signUp.layer.backgroundColor=UIColor.systemGray6.cgColor
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
