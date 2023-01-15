//
//  MyPet.swift
//  XiaowenMa-Lab2
//
//  Created by 马晓雯 on 6/21/20.
//  Copyright © 2020 Xiaowen Ma. All rights reserved.
//

class MyPet{
    //data
    var type: petTypes?
    var foodLevel:Int
    var happiness:Int
    var totalFed:Int
    var totalPlay:Int
    
    enum petTypes{
        case dog,cat,fish,bird,bunny
    }
    //func
    func feed(){
        if(foodLevel<10){
            foodLevel+=1
        }
        totalFed+=1
    }
    
    func play(){
        if(happiness<10&&foodLevel>0){
            happiness+=1
            foodLevel-=1
            totalPlay+=1
        }
        else if(happiness>=10&&foodLevel>0){
            foodLevel-=1
            totalPlay+=1
        }
    }
    
    //init
    init(type:petTypes) {
        self.type=type
        foodLevel=0
        happiness=0
        totalPlay=0
        totalFed=0
    }
    
}
