//
//  DetailedViewController.swift
//  XiaowenMa-Lab4
//
//  Created by 马晓雯 on 7/12/20.
//  Copyright © 2020 Xiaowen Ma. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    var username:String!
    var name:String!
    var date:String!
    var score:Double!
    var image:UIImage!
    var button:UIButton!
    var adult:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(username!)
        
        navigationItem.title=name
        view.backgroundColor = UIColor.white
        
        let theImageFrame = CGRect(x: view.frame.midX - image.size.width/2, y: 120, width: image.size.width, height: image.size.height)

        let imageView = UIImageView(frame: theImageFrame)
        imageView.image = image
        
        view.addSubview(imageView)
        
        
        let titleFrame = CGRect(x: 0, y: image.size.height + 120, width: view.frame.width, height: 30)
        let titleView = UILabel(frame: titleFrame)
        titleView.text = adult
        titleView.textAlignment = .center
        view.addSubview(titleView)
        
        let dateFrame=CGRect(x: 0, y: image.size.height + 150, width: view.frame.width, height: 30)
        let dateView=UILabel(frame:dateFrame)
        dateView.text=date
        dateView.textAlignment = .center
        view.addSubview(dateView)
        
        let scoreFrame=CGRect(x: 0, y: image.size.height + 180, width: view.frame.width, height: 30)
        let scoreView=UILabel(frame:scoreFrame)
        scoreView.text = "Vote Average: \(String(score))"
        scoreView.textAlignment = .center
        view.addSubview(scoreView)
        
        let buttonFrame=CGRect(x: view.frame.midX-75, y: image.size.height + 210, width: 150, height: 30)
        button=UIButton(frame:buttonFrame)
        button.setTitle("Add to Favorite", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)

        view.addSubview(button)
        

        // Do any additional setup after loading the view.
    }
    
    
    @objc func addToFavorite(){
        print("Add to Favorite")
        
        let path=Bundle.main.path(forResource: "myFavorite", ofType: "plist")
        let dict=NSMutableDictionary(contentsOfFile: path!)!
        //let moviesArray=dict.object(forKey:"FavoriteMovies") as! NSMutableArray
        print(username!)
        print(dict)
        let moviesArray=dict.object(forKey:"\(username!)") as! NSMutableArray
        print("\(moviesArray)")
        if(moviesArray.contains("\(name!)")==false){
        moviesArray.add(name!)
        dict.write(toFile: path!, atomically: true)
        print("\(dict)")
            
        let path2=Bundle.main.path(forResource: "Comments", ofType: "plist")
        let dict2=NSMutableDictionary(contentsOfFile: path2!)!
        //let commentsArray=dict2.object(forKey:"movieComments") as! NSMutableArray
        let commentsArray=dict2.object(forKey:"\(username!)") as! NSMutableArray
        print("\(commentsArray)")
        commentsArray.add("")//initialize the comment as empty string
        dict2.write(toFile: path2!, atomically: true)
        print("\(dict2)")
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
