//
//  MyViewModel.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 03.11.2020.
//

import UIKit
let notificationPost = Notification.Name("ua.edu.ukma.test.notification")
let notificationImage = Notification.Name("ua.edu.ukma.test.notificationImage")
class MyViewModel {
    
    var delegate:Delegate?
    
    
    func update(){
        UseCase.requestForUpdate()
        
    }
    init(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updatePostNotification),
                                               name: notificationPost, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateImageNotification),
                                               name: notificationImage, object: nil)
    }
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
        delegate?.updateImage(image)
        //a.updateImage(image)
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
        delegate?.updateComments("\u{1F4AC}" + post.numComments.description)
        delegate?.updateDomain(post.domain)
        delegate?.updateLikes("\u{1F44D}" + post.ups.description)
        delegate?.updateTime(timeStr)
        delegate?.updateTitle(post.title)
        delegate?.updateUserName(post.author)
    }
}
