//
//  PostTableViewCell.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 14.11.2020.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var time: UILabel!
    @IBOutlet private weak var domain: UILabel!
    @IBOutlet private weak var titleName: UILabel!
    @IBOutlet private weak var imageData: UIImageView!
    @IBOutlet private weak var likes: UILabel!
    @IBOutlet private weak var comments: UILabel!
    @IBOutlet private weak var bookmark: UIButton!
   
    override func prepareForReuse() {
        userName.text = nil
        time.text = nil
        domain.text = nil
        titleName.text = nil
       imageData.image = nil
        likes.text = nil
        comments.text = nil
        bookmark.isSelected = false
    }
    func configure(for post:Post){
        userName.text = " " + post.author
        time.text = " " + post.createdStr + "  "
        domain.text = post.domain
        titleName.text = post.title
       
        if let data = post.image{
            imageData.image = UIImage(data: data)
            //print(data)
           
        } else{
            imageData.image = UIImage(systemName: "nosign")
        }
        
        likes.text = "\u{1F44D}" + (post.ups - post.downs).description
        comments.text = "\u{1F4AC}" + post.numComments.description
        bookmark.isSelected = post.saved
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
