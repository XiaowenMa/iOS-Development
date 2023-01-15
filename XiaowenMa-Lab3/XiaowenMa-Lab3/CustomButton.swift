//
//  CustomButton.swift
//  XiaowenMa-Lab3
//
//  Created by 马晓雯 on 6/28/20.
//  Copyright © 2020 Xiaowen Ma. All rights reserved.
//

import UIKit

class CustomButton:UIButton{
    var color: UIColor?
    
    func setStyle(color:UIColor){
        self.color=color;
        self.backgroundColor=color;
    }
    
    func setSize(){
        self.layer.cornerRadius=15;
        /*
        self.heightAnchor.constraint(equalToConstant: 30).isActive=true;
        self.widthAnchor.constraint(equalToConstant: 30).isActive=true;
 */
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
