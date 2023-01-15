//
//  SpinnerViewController.swift
//  XiaowenMa-Lab4
//
//  Created by 马晓雯 on 7/13/20.
//  Copyright © 2020 Xiaowen Ma. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {
    var spinner=UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func loadView() {
       //reference: https://www.hackingwithswift.com/example-code/uikit/how-to-use-uiactivityindicatorview-to-show-a-spinner-when-work-is-happening
        view=UIView()
        view.backgroundColor=UIColor(white:1,alpha: 0.7)
        
        spinner.translatesAutoresizingMaskIntoConstraints=false;
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true;
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive=true;
        
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
