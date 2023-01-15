//
//  FavoriteController.swift
//  XiaowenMa-Lab4
//
//  Created by 马晓雯 on 7/12/20.
//  Copyright © 2020 Xiaowen Ma. All rights reserved.
//

import UIKit

class FavoriteController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var titles:[String]=[]
    var username:String!
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell(style: .default, reuseIdentifier: "tableCell")
        cell.textLabel?.text=titles[indexPath.row]
        return cell
    }
    
    func dataFromProperList(){
        //reset  the names array to empty
        titles=[]
        let path=Bundle.main.path(forResource: "myFavorite", ofType: "plist")
        let dict:AnyObject=NSDictionary(contentsOfFile: path!)!
        //let moviesArray=dict.object(forKey:"FavoriteMovies") as! Array<String>
        let moviesArray=dict.object(forKey:"\(username!)") as! Array<String>

        for movie in moviesArray{
            titles.append(movie)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                deleteFromPlist(movie: titles[indexPath.row])
            titles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
                
                deleteFromComments(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                            let commentController=self.storyboard?.instantiateViewController(identifier: "comment") as! CommentViewController
        print(titles[indexPath.row])
        commentController.movieName=titles[indexPath.row]
        commentController.favoriteIndex=indexPath.row
        commentController.username=self.username
        navigationController?.pushViewController(commentController, animated: true)
    }
    
    func deleteFromPlist(movie:String){
        let path=Bundle.main.path(forResource: "myFavorite", ofType: "plist")
        let dict=NSMutableDictionary(contentsOfFile: path!)!
        //let moviesArray=dict.object(forKey:"FavoriteMovies") as! NSMutableArray
        let moviesArray=dict.object(forKey:"\(username!)") as! NSMutableArray

        print("\(moviesArray)")
        moviesArray.remove(movie)
        dict.write(toFile: path!, atomically: true)
        print("\(dict)")
        
    }
    
    func deleteFromComments(index:Int){
        let commentController=self.storyboard?.instantiateViewController(identifier: "comment") as! CommentViewController
        commentController.username=self.username
        commentController.removeComment(index: index)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataFromProperList()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource=self
        tableView.delegate=self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        let tab=tabBarController as! myTabController
        username=tab.user!
        // Do any additional setup after loading the view.
        dataFromProperList()
        
        navigationItem.title="Favorite"
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
