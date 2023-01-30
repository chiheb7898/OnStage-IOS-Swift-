//
//  NewsViewController.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 07/04/2022.
//

import UIKit

class NewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate,UITableViewDataSource {
    
    //widgets
    @IBOutlet weak var topNews: UICollectionView!
    @IBOutlet weak var otherNews: UITableView!
    @IBOutlet weak var logo: UIBarButtonItem!
    @IBOutlet weak var profilePic: UIImageView!
    
    
    //var
    var postsViewModel = PostViewModel()
    var posts = [Post]()
    
    var PostImages = ["postimage","iphone","cyberpunk","postimage","iphone"]
    
    
    
    //widgets
    @IBOutlet weak var scroller: UIScrollView!
    
    
    //collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topPostsCell", for: indexPath)
        let contentView = cell.contentView
        
        cell.layer.cornerRadius = 10
        
        let postimage = contentView.viewWithTag(1) as! UIImageView
        postimage.layer.masksToBounds = true
        postimage.layer.cornerRadius = 5
        
        let datepost = contentView.viewWithTag(2) as! UILabel
        let title = contentView.viewWithTag(3) as! UITextView
        
        
        let imageurl = NSURL(string: posts[indexPath.row].photo!)
        var dataimage = NSData(contentsOf: imageurl as! URL)
        postimage.image = UIImage(data: dataimage as! Data)
        
        datepost.text = posts[indexPath.row].createdAt
        title.text = posts[indexPath.row].title
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "postDetailsSegue", sender: indexPath)
    }
    
    
    //TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tabcell = tableView.dequeueReusableCell(withIdentifier:"simplePostCell")
        let tabcontentView = tabcell!.contentView
        
        //tabcell.layer.cornerRadius = 10
        
        let simplepostimage = tabcontentView.viewWithTag(1) as! UIImageView
        let datepost = tabcontentView.viewWithTag(2) as! UILabel
        let title = tabcontentView.viewWithTag(3) as! UITextView
        //postimage.layer.masksToBounds = true
        //postimage.layer.cornerRadius = 5
        let imageurl = NSURL(string: posts[indexPath.row].photo!)
        var dataimage = NSData(contentsOf: imageurl as! URL)
        simplepostimage.image = UIImage(data: dataimage as! Data)
        datepost.text = posts[indexPath.row].createdAt
        title.text = posts[indexPath.row].title
        
        
        return tabcell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "postDetailsSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postDetailsSegue"  {
            let indexPath = sender as! IndexPath
            let destination = segue.destination as! PostDetailsViewController
            
            destination.idPost = posts[indexPath.row]._id
            destination.pic = posts[indexPath.row].photo
            destination.date = posts[indexPath.row].createdAt
            destination.titleDet = posts[indexPath.row].title
            destination.discription = posts[indexPath.row].description
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scroller.contentSize = CGSize(width: 414, height: 1400)
        
        //set Profile Image
        let profileimageurl = NSURL(string: UserDefaults.standard.string(forKey: "picture")!)
        let profiledataimage = NSData(contentsOf: profileimageurl as! URL)
        profilePic.image = UIImage(data: profiledataimage as! Data)
        // Do any additional setup after loading the view.
    }
    
    //functions
    
    override func viewDidAppear(_ animated: Bool) {
            initialize()
        }
        
        
        //function
        func initialize() {
            PostViewModel.sharedInstance.getAllPostes{ success, postsfromRep in
                if success {
                    self.posts = postsfromRep! as! [Post]
                    self.topNews.reloadData()
                    self.otherNews.reloadData()
                }else {
                    self.present(Alert.makeAlert(titre: "Error", message: "Could not load News "),animated: true)
                }
            }
        }
    
    
    
    //actions
    @IBAction func addPostButton(_ sender: Any) {
    }
    
    

}
