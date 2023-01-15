//
//  ViewController.swift
//  XiaowenMa-Lab2
//
//  Created by 马晓雯 on 6/20/20.
//  Copyright © 2020 Xiaowen Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    var  myPets: [MyPet]?
    var currentPet: MyPet?
    
    //for creative part
    @IBOutlet weak var friends: UISegmentedControl!
    
    @IBOutlet weak var Label: UILabel!
    
    //outlets
    
    @IBOutlet weak var totalPlay: UILabel!
    
    @IBOutlet weak var totalFed: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var happinessBar: DisplayView!
    
    @IBOutlet weak var foodLevelBar: DisplayView!
    
    @IBOutlet weak var feed: UIButton!
    
    @IBOutlet weak var play: UIButton!
    
    @IBOutlet weak var imageBackground: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        friends.setWidth(60, forSegmentAt: 0)
        
        feed.backgroundColor  = UIColor.lightGray.withAlphaComponent(0.5)
        play.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        myPets=[MyPet(type:.dog),MyPet(type:.cat),MyPet(type:.bird),MyPet(type:.fish),MyPet(type:.bunny)]
        
        currentPet=myPets![0]
        updateColor()
    }

    func switchPet(another:MyPet){
        if(another.type==currentPet!.type){
            //do nothing
        }
        else{
            switch another.type!{
            case .dog:
                currentPet=myPets![0]
            case .cat:
                currentPet=myPets![1]
            case .bird:
                currentPet=myPets![2]
            case .fish:
                currentPet=myPets![3]
            case .bunny:
                currentPet=myPets![4]
            }
            updateImage()
            updateBars()
            updateValues()
            updateColor()
        }
    }
    
    func updateImage(){
        if let petType=currentPet!.type{
            switch petType{
            case .dog:
                image.image=UIImage(named:"Dog")
            case .cat:
                image.image=UIImage(named:"Cat")
            case .bird:
                image.image=UIImage(named:"Bird")
            case .fish:
                image.image=UIImage(named:"Fish")
            case .bunny:
                image.image=UIImage(named:"Bunny")
            }
        }
    }
    
    func updateBars(){
        //this function update the displayview bar
        let hBar=Double((currentPet?.happiness)!)/10
        happinessBar.animateValue(to: CGFloat(hBar))
        
        let fBar=Double((currentPet?.foodLevel)!)/10
        foodLevelBar.animateValue(to: CGFloat(fBar))
    }
    
    func updateValues(){
        //this function will update the total number fed&played
        totalFed.text=String(currentPet!.totalFed)
        totalPlay.text=String(currentPet!.totalPlay)
    }
    
    func updateColor(){
        //this function update the background color as well as the bar color chosen a different pet
        //dog red;cat blue;bird yellow; fish  purple;bunny green
        var color:UIColor?
        if let p=currentPet{
            switch p.type!{
                case .dog:
                    //color = .systemRed
                    color=UIColor(named:"Custom_red")
                case .cat:
                    //color = .systemBlue
                    color = UIColor(named: "Custom_blue")

                case .bird:
                    //color = .systemYellow
                    color = UIColor(named: "Custom_yellow")
                case .fish:
                    //color = .systemPurple
                    color = UIColor(named: "Custom_purple")
                case .bunny:
                    //color = .systemGreen
                    color = UIColor(named: "Custom_green")
            }
        }
        happinessBar.color = color!
        foodLevelBar.color = color!
        imageBackground.backgroundColor=color!
        
    }
    
    
    @IBAction func feedPet(_ sender: Any) {
        currentPet!.feed()

        updateValues()
        updateBars()
    }
    
    
    @IBAction func playWithPet(_ sender: Any) {
        currentPet!.play()
        updateValues()
        updateBars()
    }
    
    
    @IBAction func toDog(_ sender: Any) {
        switchPet(another: myPets![0])
    }
    
    @IBAction func toCat(_ sender: Any) {
        switchPet(another: myPets![1])
    }
    
    @IBAction func toBird(_ sender: Any) {
        switchPet(another: myPets![2])
    }
    
    @IBAction func toFIsh(_ sender: Any) {
        switchPet(another: myPets![3])
    }
    
    @IBAction func toBunny(_ sender: Any) {
        switchPet(another: myPets![4])
    }
    
    
    //creative part
    @IBAction func playWithFriends(_ sender: Any) {
        //this function allow each pet to play with each other; and each combination will lead to a different result:
        //dog and cat are friends, they can play together(if either one is fed)
        //cat will kill fish/bird if the cat is fed; and the user will get a message which  says "your bird/fish dies:("
        //bird and bunny are friends, they can play together;
        //if dog is fed,when dog plays with bunny/bird, dog implements play while the happinenss of bunny/bird will decrease  by 1
        //if cat is fed,when it plays with bunny, cat will implement plat while the happinenss of bunny will decrease by 1
        
        if let p=currentPet{
            if(friends.selectedSegmentIndex == 0){
                //self, do nothing
            }
            else if(friends.selectedSegmentIndex == 1){
                switch  p.type!{
                case .dog: break
                    //do nothing
                case .cat:
                    currentPet!.play()
                    updateBars()
                    updateValues()
                    myPets![0].play()
                case .bird:
                    
                    if(currentPet!.happiness>0&&myPets![0].foodLevel>0){
                    currentPet!.happiness-=1
                    }
                    myPets![0].play()
                    updateValues()
                    updateBars()
                case .fish:break
                case .bunny:
                    
                    if(currentPet!.happiness>0&&myPets![0].foodLevel>0){
                    currentPet!.happiness-=1
                    }
                    myPets![0].play()
                    updateValues()
                    updateBars()
                }
            }
            else if(friends.selectedSegmentIndex==2){//play  with cat
                switch p.type!{
                    case .dog:
                        currentPet!.play()
                        updateValues()
                        updateBars()
                        myPets![1].play()
                    case .cat:break
                    case .bird:
                        
                        if (myPets![1].foodLevel>0){
                        //bird  died
                        
                        Label.text="Your bird died :("
                        Label.alpha=1
                            UIView.animate(withDuration: 1, animations: { () -> Void in
                            self.Label.alpha = 0
                        })
                        currentPet!=MyPet(type: .bird)
                        friends.selectedSegmentIndex=0
                        }
                        myPets![1].play()
                        
                        updateValues()
                        updateBars()
                    case .fish:
                        if(myPets![1].foodLevel>0){
                        //fish  died
                            
                        Label.text="Your fish died :("
                        Label.alpha=1
                        UIView.animate(withDuration: 1, animations: { () -> Void in
                            self.Label.alpha = 0
                        })

                        currentPet!=MyPet(type: .fish)
                        friends.selectedSegmentIndex=0
                        }
                        myPets![1].play()
                        updateValues()
                        updateBars()
                    case .bunny:
                        
                        if(currentPet!.happiness>0&&myPets![1].foodLevel>0){
                        currentPet!.happiness-=1
                        }
                        myPets![1].play()
                        updateValues()
                        updateBars()
                }
                }
            else  if(friends.selectedSegmentIndex==3){//play  with bird
                switch p.type!{
                    case .dog://dog play with bird
                        if(myPets![2].happiness>0&&currentPet!.foodLevel>0){
                            myPets![2].happiness-=1
                    }
                    currentPet!.play()
                    updateValues()
                    updateBars()
                    case .cat:
                        if(currentPet!.foodLevel>0){
                        //bird dies
                        myPets![2]=MyPet(type: .bird)
                            Label.text="Your bird died :("
                            Label.alpha=1
                            UIView.animate(withDuration: 1, animations: { () -> Void in
                                self.Label.alpha = 0
                            })
                    }
                    currentPet!.play()
                    updateValues()
                    updateBars()
                    
                    case .bird:break
                    case .fish:break
                    case .bunny:
                        myPets![2].play()
                        currentPet!.play()
                        updateValues()
                        updateBars()
                }
            }
            else  if(friends.selectedSegmentIndex==4){//play with fish
                switch p.type!{
                    case .dog:break
                    case .cat:
                        if(currentPet!.foodLevel>0){
                        //fish dies
                        myPets![3]=MyPet(type: .fish)
                        Label.text="Your fish died  :("
                            Label.alpha=1
                        UIView.animate(withDuration: 1, animations: { () -> Void in
                                self.Label.alpha = 0
                        })

                    }
                    currentPet!.play()
                    updateValues()
                    updateBars()
                    
                    case .bird:break
                    case .fish:break
                    case .bunny:break
                }
            }
            else{//play with  bunny
                switch p.type!{
                    case .dog:

                        if(myPets![4].happiness>0&&currentPet!.foodLevel>0){
                            myPets![4].happiness-=1
                    }
                    currentPet!.play()
                    updateValues()
                    updateBars()
                    case .cat:
                        if(myPets![4].happiness>0&&currentPet!.foodLevel>0){
                            myPets![4].happiness-=1
                        }
                    currentPet!.play()
                    updateValues()
                    updateBars()
                    case .bird:
                    myPets![4].play()
                    currentPet!.play()
                    updateValues()
                    updateBars()
                    case .fish:break
                    case .bunny:break
                }
            }
            
        }
    }
    
    //

    
}

