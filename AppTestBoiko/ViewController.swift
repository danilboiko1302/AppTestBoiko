//
//  ViewController.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 01.11.2020.
//

import UIKit
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
    
    private var position: Int = 0
    
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var time: UILabel!
    @IBOutlet private weak var domain: UILabel!
    @IBOutlet private weak var titleName: UILabel!
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var likes: UILabel!
    @IBOutlet private weak var comments: UILabel!
    @IBOutlet private weak var bookmark: UIButton!
    @IBOutlet private weak var ViewImage: UIView!
    
    @IBOutlet private weak var BShare: UIButton!
    @IBAction func BShare_click(_ sender: Any) {
        //print("WTF")
    }
    @IBAction private func bookmarkPress(_ sender: Any) {
        bookmark.isSelected = !bookmark.isSelected
        UseCase.saved(name: userName!.text!, title: titleName!.text!)
    }
    
    func updateFull(_ post:Post, pos:Int){
        position = pos
        updateTitle(post.title)
        updateTime(post.createdStr)
        if let data = post.image{
            updateImage(data)
        } else{
            main.async {
                self.image.image = UIImage(systemName: "nosign")
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
            self.bookmark.isSelected = bool
        }
    }
    
    
    
    //override func view
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        myViewModel.update()
//        myViewModel.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)()
       
        
    }
    
    
    
}


