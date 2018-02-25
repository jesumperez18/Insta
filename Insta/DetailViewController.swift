//
//  DetailViewController.swift
//  Insta
//
//  Created by Jesus perez on 2/25/18.
//  Copyright © 2018 Jesus perez. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {

  
    @IBOutlet weak var instaTimeStamp: UILabel!
    @IBOutlet weak var instaCaption: UILabel!
    @IBOutlet weak var instaImage: PFImageView!
    
    var imageFile: PFFile!
    var postDate: String!
    var postCaption: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instaImage.file = imageFile
        instaImage.loadInBackground()
        instaCaption.text = postCaption
        instaTimeStamp.text = postDate
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
