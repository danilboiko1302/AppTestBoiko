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
    var delegateArr:DelegateArr?
    
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
        
        delegateArr?.update(UseCase.dataArr)
    }
    func filter(_ str:String){
        var res: [Post] = []
        if(str == ""){
            delegateArr?.update(UseCase.dataArr)
        } else{
            for item in UseCase.dataArr{
                if item.title.lowercased().range(of:str.lowercased()) != nil {
                    res.append(item)
                }
            }
            delegateArr?.update(res)
        }
       
    }
}
