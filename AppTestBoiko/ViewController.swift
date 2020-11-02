//
//  ViewController.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 01.11.2020.
//

import UIKit
let notificationName = Notification.Name("ua.edu.ukma.test.notification")
class ViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var domain: UILabel!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var comments: UILabel!
    let main = DispatchQueue.main
    @objc
    func handleMyNotification() {
        update()
        }
        
       
    func update(){
       
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
        print(post.description)
        let url = URL(string: "https://cdn.arstechnica.net/wp-content/uploads/2018/06/macOS-Mojave-Dynamic-Wallpaper-transition.jpg")!
        downloadImage(from: url)
        main.async {
            self.userName.text = post.author
            self.time.text = timeStr
            self.domain.text = post.domain
            self.titleName.text = post.title
            self.likes.text = post.ups.description
            self.comments.text = post.numComments.description
          
        }
       
    }
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self!.image.image = UIImage(data: data)
            }
        }
    }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleMyNotification),
                                               name: notificationName, object: nil)
        UseCase.requestForUpdate()
        // Do any additional setup after loading the view.
    }
    
    
    

}


