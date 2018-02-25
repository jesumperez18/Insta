//
//  InstaCell.swift
//  Insta
//
//  Created by Jesus perez on 2/24/18.
//  Copyright © 2018 Jesus perez. All rights reserved.
//
import UIKit
import Parse
import ParseUI


class InstaCell: UITableViewCell {


   
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
