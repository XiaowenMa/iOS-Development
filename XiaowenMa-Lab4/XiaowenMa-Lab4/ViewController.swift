//
//  ViewController.swift
//  XiaowenMa-Lab4
//
//  Created by 马晓雯 on 7/6/20.
//  Copyright © 2020 Xiaowen Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    var currentUser:String?
    var popular="https://api.themoviedb.org/3/movie/popular?api_key=a951ad594f9ce6a5f174b2bc087ab32c&language=en-US&page=1"
    
    let languages=["English","Chinese","French","Spanish"]
    //en-US zh fr es
    var language=""
    
    //api_key=a951ad594f9ce6a5f174b2bc087ab32c
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies:[Movie]=[]
    var imageCache:[UIImage]=[]
    var inputString="fast"
    var largerImages:[UIImage]=[]
    
    let spinner=SpinnerViewController()
    //
    struct APIResults:Decodable {
        let page: Int
        let total_results: Int
        let total_pages: Int
        let results: [Movie]
    }
    
    struct Movie:Decodable{
        let id: Int!
        let poster_path: String?
        let title: String
        let release_date: String?
        let vote_average: Double
        let overview: String
        let vote_count:Int!
        let adult:Bool?
    }
  /*
    //try store the images into File System
    func filePath(forKey key:String) -> URL?{
        let fileManager = FileManager.default
        if let documentURL = fileManager.urls(for: .documentDirectory,in: FileManager.SearchPathDomainMask.userDomainMask).first{
            let path = key+".png"
            return documentURL.appendingPathComponent(path)
        } else { return nil }

        
    }
    
    func store(image: UIImage, forKey key:String){
        if let pngRepresentation = image.pngData(){
            if let filePath = filePath(forKey: key) {
                do  {
                    try pngRepresentation.write(to: filePath,
                                                options: .atomic)
                } catch let err {
                    print("Saving file resulted in error: ", err)
                }
            }
        }
    }
    
    func retrieveImage(forKey key: String) -> UIImage? {

            if let filePath = self.filePath(forKey: key),
                let fileData = FileManager.default.contents(atPath: filePath.path),
                let image = UIImage(data: fileData) {
                return image
            }
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
                let image = UIImage(data: imageData) {
                return image
            }
        
        return nil
    }
    */
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        language=languages[row]
        print(language)
    }
    
    func createSpinner(){
        
        addChild(spinner)
        spinner.view.frame=view.frame
        //spinner.view.frame=collectionView.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DVC=DetailedViewController()
        DVC.username=currentUser!
        if let a=(movies[indexPath.row].adult){
            if(a){
                DVC.adult="Age Group: Adult"
            }
            else{
                DVC.adult="Age Group: All Ages"
            }
        }else{
            DVC.adult="Age Group: Not Specified"
        }
        if let release=movies[indexPath.row].release_date{
            DVC.date="Release date:\(release)"
        }else{
            DVC.date="Release date: Unknown"
        }
        DVC.name=movies[indexPath.row].title
        DVC.score=movies[indexPath.row].vote_average
        print(DVC.name!)
        
        DVC.image=largerImages[indexPath.row]
        
        navigationController?.pushViewController(DVC, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        inputString=searchBar.text ?? ""
        inputString=inputString.trimmingCharacters(in: .newlines)
        inputString = inputString.trimmingCharacters(in: .punctuationCharacters)

        if(inputString.trimmingCharacters(in: .whitespacesAndNewlines) != ""){
        searchBar.text=nil
        //start spinning
        createSpinner()
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchDataForCollectionView()
            //print()
            //reset imageCache for new movie
            self.imageCache=[]
            self.largerImages=[]
            self.cacheImage()
            DispatchQueue.main.async {
                print("reloading")
                self.collectionView.reloadData()
                self.spinner.willMove(toParent: nil)
                self.spinner.view.removeFromSuperview()
                self.spinner.removeFromParent()
            }

        }
        print(inputString)
        }
    }
    
    //extra credit
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configuration=UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: {actions -> UIMenu? in
            let myAction=UIAction(title: "Add to Favorite", image: UIImage(systemName: "star.fill"), handler: {action in
                let path=Bundle.main.path(forResource: "myFavorite", ofType: "plist")
                let dict=NSMutableDictionary(contentsOfFile: path!)!
                //let moviesArray=dict.object(forKey:"FavoriteMovies") as! NSMutableArray
                let moviesArray=dict.object(forKey:"\(self.currentUser!)") as! NSMutableArray
                if(!moviesArray.contains(self.movies[indexPath.row].title)){
                moviesArray.add(self.movies[indexPath.row].title)
                dict.write(toFile: path!, atomically: true)
                
                let path2=Bundle.main.path(forResource: "Comments", ofType: "plist")
                let dict2=NSMutableDictionary(contentsOfFile: path2!)!
                //let commentsArray=dict2.object(forKey:"movieComments") as! NSMutableArray
                    let commentsArray=dict2.object(forKey:"\(self.currentUser!)") as! NSMutableArray

                commentsArray.add("")//initialize the comment as empty string
                dict2.write(toFile: path2!, atomically: true)
                }
                })
            let myAction2=UIAction(title:"Save to Photos",image:UIImage(systemName: "photo"),handler: {action in
                let image=self.imageCache[indexPath.row]
                print("save")
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            })
            return UIMenu.init(title: "\(self.movies[indexPath.row].title)", image: nil, identifier: nil, options: .destructive, children: [myAction,myAction2])
        })
        return configuration
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            //return CGSize(width: 200, height: 200)
            return CGSize(width:150,height:230)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
        //return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! movieCell
        print(cell.name)
        cell.posterImage!.image=imageCache[indexPath.row]
        cell.title.text=movies[indexPath.row].title

        print(indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    func fetchDataForCollectionView(){
        var lg=""
        if(language=="English"){
            lg="en-US"
        }
        else if(language=="Chinese"){
            lg = "zh"
        }
        else if(language=="French"){
            lg="fr"
        }
        else{
            lg="es"
        }
        var search=""
        if(popular != ""){
            search=popular
            popular=""
        }
        else{
            let input=inputString.replacingOccurrences(of:" ",with:"%20")//clear the user input(%20 is for " " recogonized by tmdb)
            print(input)
            search="https://api.themoviedb.org/3/search/movie?api_key=a951ad594f9ce6a5f174b2bc087ab32c&language="+lg+"&query="+input+"&page=1&include_adult=false"
        }
        //let search="https://api.themoviedb.org/3/search/movie?api_key=a951ad594f9ce6a5f174b2bc087ab32c&language=en-US&query="+inputString+"&page=1&include_adult=false"
        let url=URL(string:search)

        var data:Data?
        do{
            data = try Data(contentsOf: url!)
        }catch{
            let alert = UIAlertController(title: "Search Failed", message: "Error: failed in fetching data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        var searchResult=APIResults(page:0,total_results: 0,total_pages: 0,results: [])
        do {
            searchResult = try JSONDecoder().decode(APIResults.self, from:data!)
        }catch{
            let alert = UIAlertController(title: "Search Failed", message: "Error: failed in fetching data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        self.movies=searchResult.results
        print("the data is \(movies)")
    }
    
    func cacheImage(){
        //get the plist to store the movies' names
 /*
        let path=Bundle.main.path(forResource: "SavedNames", ofType: "plist")
        let dict=NSMutableDictionary(contentsOfFile: path!)!
        let savedNames=dict.object(forKey:"Titles") as! NSMutableArray
        print("\(savedNames)")
 */
        
        
        for item in movies {
            print(item.poster_path ?? "No Poster")
            if let poster=item.poster_path{
            let fullPath="https://image.tmdb.org/t/p/w200"+poster
            let url = URL(string: fullPath)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)
    /*
            //try to store the poster locally
            store(image: image!,forKey: item.title)
            //save the names to the plist
            savedNames.add(item.title)
 */
                
            self.imageCache.append(image!)
            
            let fullP="https://image.tmdb.org/t/p/w300"+poster
            let Lurl = URL(string: fullP)
            let Ldata = try? Data(contentsOf: Lurl!)
            let largerImage = UIImage(data: Ldata!)
            self.largerImages.append(largerImage!)
            }
            else{
                /*
                //no poster, only save the names to the plist
                savedNames.add(item.title)
 */
                
                //put a placeholer image if the movie doesn't have a poster
                self.imageCache.append(UIImage(named:"PH")!)
                self.largerImages.append(UIImage(named:"PH")!)
            }
        }
        /*
        dict.write(toFile: path!, atomically: true)
        print("\(dict)")
 */
    }
    
    func addNewUser(username:String){
        let path=Bundle.main.path(forResource: "users", ofType: "plist")
        let allUsers=NSMutableArray(contentsOfFile: path!)!
        print(allUsers)
        if(!allUsers.contains(username)){
            allUsers.add(username)
            print(allUsers)
            allUsers.write(toFile: path!, atomically: true)
            
            let path2=Bundle.main.path(forResource: "myFavorite", ofType: "plist")
            let dict=NSMutableDictionary(contentsOfFile: path2!)
            dict?.addEntries(from: [username:NSMutableArray()])
            print(dict!)
            dict?.write(toFile: path2!, atomically: true)
            
            let path3=Bundle.main.path(forResource: "Comments", ofType: "plist")
            let dict2=NSMutableDictionary(contentsOfFile: path3!)
            dict2?.addEntries(from: [username:NSMutableArray()])
            dict2?.write(toFile: path3!, atomically: true)
        }

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource=self
        collectionView.delegate=self
        searchBar.delegate=self
        pickerView.dataSource=self
        pickerView.delegate=self
        
        language="English"//set the default language as English
        let tab=tabBarController as! myTabController
        //print(tab.user!)
        self.currentUser=tab.user
        print(currentUser!)
        addNewUser(username: currentUser!)
        
        navigationItem.title="Movies"
        
        //!!!Using storyboard, do not register the cell!!! or the registration will lose the outlet
        //collectionView.register(movieCell.self, forCellWithReuseIdentifier: "myCell")
        createSpinner()//create a view for spinner
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchDataForCollectionView()
            print()
            self.cacheImage()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.spinner.willMove(toParent: nil)
                self.spinner.view.removeFromSuperview()
                self.spinner.removeFromParent()
                
            }

        }
        
    }


}

