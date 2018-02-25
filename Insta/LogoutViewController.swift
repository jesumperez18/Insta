//
//  LogoutViewController.swift
//  Insta
//
//  Created by Jesus perez on 2/21/18.
//  Copyright © 2018 Jesus perez. All rights reserved.
//

import UIKit
import Parse

class LogoutViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    
    @IBOutlet weak var postTableView: UITableView!
   
    var posts: [Post] = []
    var refreshControl : UIRefreshControl!
    
    func fetch(){
        let query = Post.query()
        query?.limit = 20
        query?.order(byDescending: "_created_at")
        // fetch data asynchronously
        query?.findObjectsInBackground(block: { (posts, error) in
            if  posts != nil {
                // do something with the data fetched
               // print("Reached this line senpai")
                self.posts = posts as! [Post]
                print(self.posts)
                self.postTableView.reloadData()
            
            } else {
                // handle error
                print(error?.localizedDescription)
            }
        })

        
        
    }
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(LogoutViewController.didPullToReFresh(_:)), for: .valueChanged)
        postTableView.insertSubview(refreshControl, at: 0)
        self.postTableView.dataSource = self
        self.postTableView.delegate = self
        fetch()
      
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCompose(_ sender: Any) {
         self.performSegue(withIdentifier: "onCompose", sender: nil)
        
    }
    @IBAction func logOut(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            // PFUser.current() will now be nil
            print("User was successfully logged out")
            print(error?.localizedDescription as Any)
            self.performSegue(withIdentifier: "logoutSegue", sender: nil)
        }
    }
    @objc func didPullToReFresh(_ refreshControl: UIRefreshControl){
        fetch()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstaCell", for: indexPath) as! InstaCell
         print("Stuffz Happened")
        let post = posts[indexPath.section]
        
        //cell.postImageView.file = post.media
        
        if let imageFile : PFFile = post.media {
            imageFile.getDataInBackground(block: { (data, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        // Async main thread
                        
                        let image = UIImage(data: data!)
                       cell.postImageView.image = image
                       
                        
                    }
                } else {
                    print(error!.localizedDescription)
                }
            })
        }
        cell.captionLabel.text = post.caption
       //cell.postImageView.loadInBackground()
        print("Stuffz should be working")
        return cell
        
        
        
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            let vc = segue.destination as! DetailViewController
            let senderCell = sender as! InstaCell
            
            let indexPath = postTableView.indexPath(for: senderCell)
            
            let df = DateFormatter()
            df.dateStyle = .short
            df.timeStyle = .short
            df.locale = Locale.current
            
            
            vc.postDate = df.string(from: self.posts[(indexPath?.section)!].createdAt!)
            vc.imageFile = self.posts[(indexPath?.section)!].media
            vc.postCaption = self.posts[(indexPath?.section)!].caption
        }else if segue.identifier == "logoutSegue"{
            
        }
    }
   
    
   
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
