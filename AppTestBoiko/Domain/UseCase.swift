//
//  UseCase.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 02.11.2020.
//

import Foundation
class UseCase{
    static var  data:Post = Post()
    
    static var  image:Data = Data()
    
    
    static func saved(){
        Repository.updateSavedPost()
        
    }
    
    static func requestForUpdate (){
       // print("I am UseCase, I need to get new Information from Repository.")
        Repository.requestForUpdate()
    }
    
    static func requestForImage (){
       // print("Repository.requestForUpdate()")
        Repository.requestForImage()
    }
    static func updateImage(image: Data?){
        if let data = image{
            self.image = data
            NotificationCenter.default.post(Notification(name: notificationImage))
        }
       
    }
    
    
    static func updatePost(data: PostStr?){
       // print("I am UseCase, I got new information from Repository, I will process it and update View")
        var post:Post
        if let data = data{
            post = Post(author: data.author, domain: data.domain, created: Date(timeIntervalSince1970: Double(data.created) ?? 0.0), title: data.title, numComments: Int(data.numComments) ?? 0, ups: Int(data.ups) ?? 0, downs: Int(data.downs) ?? 0, thumbnail: data.thumbnail)
        } else{
            post = Post()
        }
        self.data = post
        NotificationCenter.default.post(Notification(name: notificationPost))
        requestForImage()
    }
}


