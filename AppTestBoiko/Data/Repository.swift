//
//  Repository.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 02.11.2020.
//

import Foundation
class Repository{
    
    static var saved:Bool = false
    
    static func updateSavedPost(title:String){
        //print(PersistenceManager.resData)
        for item in (0...PersistenceManager.resData.count - 1 ){
            if( PersistenceManager.resData[item].title ==  title){
                print("go")
                PersistenceManager.resData[item].saved = !PersistenceManager.resData[item].saved
                break
            }
        }
        
       // print(PersistenceManager.resData)
    }
    
    
    static func requestForUpdate(){
        //print("I am Repository, I need to update information in PersistenceManager, HTTPServise will help me.")
        HTTPService.getRequest(url: "https://www.reddit.com", params:["r","ios","top.json"],paramsKeyValue: ["limit":(PersistenceManager.resData.count + 4).description])
        
        
    }
    
    
    static func requestForImage(_ str:String)->Data?{
      
          return HTTPService.loadImage(url: str)
        
    }
    
    static func changeSaved(){
        
        saved = !saved
        updatePostArr()
    }
  
    static func updatePostArr(){
       // print("I am Repository, info in PersistenceManager changed, I need to send it back to UserCase.")
        if (saved){
            var res: [PostStr] = []
            for item in PersistenceManager.resData{
                if item.saved {
                    res.append(item)
                }
            }
            UseCase.updatePostArr(data: res)
        } else {
            UseCase.updatePostArr(data: PersistenceManager.resData)
        }
        
    }
   
    static func getInfo()->[PostStr]{
        return PersistenceManager.resData
    }
}


