//
//  UseCase.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 02.11.2020.
//

import Foundation
class UseCase{
    static var  data:Post = Post()
    static var  dataArr:[Post] = []
    static var  image:Data = Data()
    static var  copy:[Post] = []
    
    
    
    
    
    static func changeSaved(){
        Repository.changeSaved()
    }
    
    static func saved(name:String, title:String){
        //print(dataArr)
        //print(title)
        for item in (0...dataArr.count - 1 ){
            if( dataArr[item].title ==  title){
                //   print("go")
                dataArr[item].saved = !dataArr[item].saved
                Repository.updateSavedPost(title: title)
                break
            }
        }
        
        
    }
    
    static func requestForUpdate (){
        // print("I am UseCase, I need to get new Information from Repository.")
        Repository.requestForUpdate()
    }
    
    
    static func requestForImage (_ string: String)->Data?{
        // print("Repository.requestForUpdate()")
        return Repository.requestForImage(string)
    }
    static func requestForImageSaved (_ string: String)->Data?{
        // print("Repository.requestForUpdate()")
        return Repository.requestForImageSaved(string)
    }
    static func updateImage(image: Data?){
        if let data = image{
            self.image = data
            NotificationCenter.default.post(Notification(name: notificationImage))
        }
        
    }
    static func updatePostArr(data: [PostStr]){
        // print("I am UseCase, I got new information from Repository, I will process it and update View")
        
        dataArr = []
        for i in data{
            
            var timeInterval = Date(timeIntervalSince1970: Double(i.created)!).timeIntervalSinceNow
            var timeStr = ""
            if(timeInterval < 0 ){
                timeInterval = -timeInterval
            }
            
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
            //  print(i.url)
            if i.thumbnail != "self"{
                //print("asdasd")
                var data:Data?
                if i.saved{
                    //  print("UseCase load Image")
                    data = requestForImageSaved(i.title)
                }else{
                    data = requestForImage(i.thumbnail)
                }
                
                dataArr.append(Post(author: i.author, domain: i.domain, created: Date(timeIntervalSince1970: Double(i.created) ?? 0.0), createdStr: timeStr, title: i.title, numComments: Int(i.numComments) ?? 0, ups: Int(i.ups) ?? 0, downs: Int(i.downs) ?? 0, thumbnail: i.thumbnail, image: data, saved: i.saved, url: i.url, comments: i.comments))
            } else {
                //print(i.thumbnail)
                dataArr.append(Post(author: i.author, domain: i.domain, created: Date(timeIntervalSince1970: Double(i.created) ?? 0.0), createdStr: timeStr, title: i.title, numComments: Int(i.numComments) ?? 0, ups: Int(i.ups) ?? 0, downs: Int(i.downs) ?? 0, thumbnail: i.thumbnail, saved: i.saved, url: i.url,comments: i.comments))
            }
            
            
            
            
        }
        
        //print("add to arr")
        // print(dataArr)
        //  print(dataArr)
        NotificationCenter.default.post(Notification(name: notificationPost))
        // requestForImage()
    }
}


