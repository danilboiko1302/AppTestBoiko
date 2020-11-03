//
//  Repository.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 02.11.2020.
//

import Foundation
class Repository{
    
    
    static func updateSavedPost(){
        if let post = PersistenceManager.res{
            var copy = post
            copy.saved =  !copy.saved
            PersistenceManager.res = copy
        }
    }
    
    
    static func requestForUpdate(){
        //print("I am Repository, I need to update information in PersistenceManager, HTTPServise will help me.")
        HTTPService.getRequest(url: "https://www.reddit.com", params:["r","ios","top.json"],paramsKeyValue: ["limit":"1"])
        
    }
    static func requestForImage(){
       // print("HTTPService.loadImage(url: url)")
        if let post = PersistenceManager.res{
            let url = post.thumbnail
            HTTPService.loadImage(url: url)
        }
    }
    static func updatePost(){
       // print("I am Repository, info in PersistenceManager changed, I need to send it back to UserCase.")
        UseCase.updatePost(data: PersistenceManager.res)
    }
    static func updateImage(){
       // print("UseCase.updateImage")
        UseCase.updateImage(image: PersistenceManager.image)
    }
}


