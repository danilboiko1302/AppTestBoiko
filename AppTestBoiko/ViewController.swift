//
//  ViewController.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 01.11.2020.
//

import UIKit
import SwiftUI
protocol Delegate {
    func updateUserName(_ str:String)
    func updateTime(_ str:String)
    func updateDomain(_ str:String)
    func updateTitle(_ str:String)
    func updateImage(_ image:Data)
    func updateLikes(_ str:String)
    func updateComments(_ str:String)
}
class ViewController: UIViewController, Delegate {
    
    
    private let main = DispatchQueue.main
    private var temp:[Comment] = []
    private var position: Int = 0
    var items:[URL] = []
    @IBOutlet private weak var bookmark: UIBookmark!
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var time: UILabel!
    @IBOutlet private weak var domain: UILabel!
    @IBOutlet private weak var titleName: UILabel!
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var likes: UILabel!
    @IBOutlet private weak var comments: UILabel!
    //@IBOutlet private weak var bookmark: UIButton!
    @IBOutlet private weak var ViewImage: UIView!
    
    @IBOutlet private weak var commentsView: UIView!
    @IBOutlet private weak var BShare: UIButton!
    @IBAction func BShare_click(_ sender: Any) {
        
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @objc func tapDetected() {
        // print("op")
        bookmark.save()
        //bookmark.isSelected = !bookmark.isSelected
        UseCase.saved(name: userName!.text!, title: titleName!.text!)
    }
    func updateFull(_ post:Post, pos:Int){
        temp = post.comments
        
        items.append(URL(string: post.url)!)
        
        
        //Action
        
        
        // function which is triggered when handleTap is called
        func handleTap(_ sender: UITapGestureRecognizer) {
            //  print("Hello World")
        }
        position = pos
        updateTitle(post.title)
        updateTime(post.createdStr)
        if let data = post.image{
            updateImage(data)
        } else{
            main.async {
                self.image.image = UIImage(systemName: "nosign")
                let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.tapDetected))
                singleTap.numberOfTapsRequired = 2
                self.image.isUserInteractionEnabled = true
                self.image.addGestureRecognizer(singleTap)
            }
        }
        
        
        updateDomain(post.domain)
        updateLikes("\u{1F44D}" + (post.ups - post.downs).description)
        updateComments("\u{1F4AC}" + post.numComments.description)
        updateUserName(post.author)
        updateBookmark(post.saved)
    }
    
    
    func updateUserName(_ str:String){
        main.async {
            self.userName.text = " " + str
        }
    }
    func updateTime(_ str:String){
        main.async {
            self.time.text = " " + str + "  "
        }
    }
    func updateDomain(_ str:String){
        main.async {
            self.domain.text = str
        }
    }
    func updateTitle(_ str:String){
        main.async {
            self.titleName.text = str
        }
        
    }
    func updateImage(_ image:Data){
        main.async {
            self.image.image = UIImage(data: image)
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.tapDetected))
            singleTap.numberOfTapsRequired = 2
            self.image.isUserInteractionEnabled = true
            self.image.addGestureRecognizer(singleTap)
        }
    }
    func updateLikes(_ str:String){
        main.async {
            self.likes.text = str
        }
    }
    func updateComments(_ str:String){
        main.async {
            self.comments.text = str
        }
    }
    func updateBookmark(_ bool:Bool){
        
        main.async {
            self.bookmark.saved = bool
            self.bookmark.setNeedsDisplay()
            
        }
    }
    
    
    
    //override func view
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.tapDetected))
        self.bookmark.isUserInteractionEnabled = true
        self.bookmark.addGestureRecognizer(singleTap)
        //        let circleView = CommentList(comments: [Comment(author: "1", body: "2", time: "3"),Comment(author: "11", body: "22", time: "33"),Comment(author: "1", body: "2", time: "3"),Comment(author: "11", body: "22", time: "33")])
        //
        //        let controller = UIHostingController(rootView: circleView)
        //        addChild(controller)
        //                controller.view.translatesAutoresizingMaskIntoConstraints = false
        //                commentsView.addSubview(controller.view)
        //                controller.didMove(toParent: self)
        if temp.count != 0{
            let a = CommentList(comments:temp)
            let childView = UIHostingController(rootView: a)
            
            addChild(childView)
            
            childView.view.frame = commentsView.frame
            
            view.addSubview(childView.view)
            childView.didMove(toParent: self)
        }
        
        
        
        //        myViewModel.update()
        //        myViewModel.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)()
        
        
    }
    
    
    
}


