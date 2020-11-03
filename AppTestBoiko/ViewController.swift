//
//  ViewController.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 01.11.2020.
//

import UIKit
let notificationPost = Notification.Name("ua.edu.ukma.test.notification")
let notificationImage = Notification.Name("ua.edu.ukma.test.notificationImage")
class ViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var domain: UILabel!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var bookmark: UIButton!
    let main = DispatchQueue.main
    @objc
    func updatePostNotification() {
        updatePost()
        }
    @objc
    func updateImageNotification() {
        updateImage()
        }
    
    func updateImage(){
        let image = UseCase.image
        DispatchQueue.main.async() { [weak self] in
            self!.image.image = UIImage(data: image)
        }
    }
    @IBAction func bookmarkPress(_ sender: Any) {
        bookmark.isSelected = !bookmark.isSelected
        UseCase.saved()
    }
    func updatePost(){
       
        let post = UseCase.data
        var timeInterval = post.created.timeIntervalSinceNow
        var timeStr = ""
        timeInterval = -timeInterval
        if(timeInterval < 60){
            timeStr = "\(Int(timeInterval)) sec"
        } else if(timeInterval < 3600){
            timeStr = "\(Int(timeInterval/60)) min"
        }  else if(timeInterval < (3600 * 24)){
            timeStr = "\(Int(timeInterval/3600)) hour"
        } else if(timeInterval < (3600  * 24*7)){
            timeStr = "\(Int(timeInterval/3600/24)) days"
        } else if(timeInterval < (2592000)){
            timeStr = "\(Int(timeInterval/3600/24/7)) weeks"
        } else if(timeInterval < (31556926)){
            timeStr = "\(Int(timeInterval/3600/24/7/4)) months"
        } else {
            timeStr = "\(Int(timeInterval/3600/24/7/4/12)) years"
        }
        
    
        main.async {
            self.userName.text = post.author
            self.time.text = timeStr
            self.domain.text = post.domain
            self.titleName.text = post.title
            self.likes.text = post.ups.description
            self.comments.text = post.numComments.description
          
        }
       
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updatePostNotification),
                                               name: notificationPost, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateImageNotification),
                                               name: notificationImage, object: nil)
        UseCase.requestForUpdate()
        // Do any additional setup after loading the view.
    }
    
    
    

}


