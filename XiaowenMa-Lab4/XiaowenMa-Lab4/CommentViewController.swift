//
//  CommentViewController.swift
//  XiaowenMa-Lab4
//
//  Created by 马晓雯 on 7/13/20.
//  Copyright © 2020 Xiaowen Ma. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    var favoriteIndex:Int!
    var movieName:String!
    var username:String!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var editBox: UITextView!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title="My Note"
        movieTitle.text=movieName
        movieTitle.layer.cornerRadius=8;
        movieTitle.layer.backgroundColor=UIColor.systemGray6.cgColor
        //self.comment.layer.borderWidth=1
        //self.comment.layer.borderColor=UIColor.lightGray.cgColor
        self.comment.layer.cornerRadius=15
        self.comment.layer.backgroundColor=UIColor.systemGray6.cgColor
        self.editBox.layer.borderWidth=1
        self.editBox.layer.borderColor=UIColor.lightGray.cgColor
        self.editBox.layer.cornerRadius=15
        loadComment()
    }
    
    
    @IBAction func updateComments(_ sender: Any) {
        if let content=editBox.text{//there is content in the editing box, so we can update the comments
            if(content != ""){//check if the content is empty(if let is not necessary)
            let path2=Bundle.main.path(forResource: "Comments", ofType: "plist")
            let dict2=NSMutableDictionary(contentsOfFile: path2!)!
            //let commentsArray=dict2.object(forKey:"movieComments") as! NSMutableArray
            let commentsArray=dict2.object(forKey:"\(username!)") as! NSMutableArray
            print("\(commentsArray)")
            commentsArray[favoriteIndex]=content//initialize the comment as empty string
            dict2.write(toFile: path2!, atomically: true)
            print("\(dict2)")
            
            editBox.text=""//clear the input text field
            loadComment()//after update the comment, reload it
            }
        }
    }
    
    func loadComment(){
        let path2=Bundle.main.path(forResource: "Comments", ofType: "plist")
        let dict2=NSDictionary(contentsOfFile: path2!)!
        //let commentsArray=dict2.object(forKey:"movieComments") as! Array<String>
        let commentsArray=dict2.object(forKey:"\(username!)") as! Array<String>
        comment.text=commentsArray[favoriteIndex]
    }
    
    func removeComment(index:Int){
        let path2=Bundle.main.path(forResource: "Comments", ofType: "plist")
        let dict2=NSMutableDictionary(contentsOfFile: path2!)!
        //let commentsArray=dict2.object(forKey:"movieComments") as! NSMutableArray
        let commentsArray=dict2.object(forKey:"\(username!)") as! NSMutableArray
        print("\(commentsArray)")
        commentsArray.removeObject(at: index)
        dict2.write(toFile: path2!, atomically: true)
        print("\(dict2)")
        
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
