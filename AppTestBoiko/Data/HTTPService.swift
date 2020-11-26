//
//  HTTPService.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 02.11.2020.
//

import Foundation
class HTTPService{
    static func getRequest(url:String, params:[String] = [], paramsKeyValue:[String:String] = [:]) {
        //print("I am HTTPService, I need to create request and HTTPRequest will send it.")
        var url = url
        for key in params{
            url = url + "/" + key
        }
        if paramsKeyValue.capacity != 0{
            url = url + "?"
            for key in paramsKeyValue{
                url = url + key.key + "=" + key.value + "&"
                
            }
            url = String(url.prefix(url.count-1))
        }
        HTTPRequester.getRequest(url,completionHandler: { ( data) -> Void in
            if let data = data{
                //print("I am HTTPService, I got new data from HTTPRequest, I will parse it and update it in PersistenceManager.")
                decode(data)
            }
        })
        
    }
    //    static func loadImage(url:String){
    //        //print("HTTPRequester.loadImage")
    //        let urlReq = URL(string: url)!
    //        HTTPRequester.loadImage(url: urlReq) { (data) in
    //            if let data = data{
    //            //    print("get")
    //                PersistenceManager.image = data
    //            }
    //        }
    //
    //    }
    
    static func loadImage(url:String) -> Data?{
        //print("HTTPRequester.loadImage")
        if let urlReq = URL(string: url){
            return HTTPRequester.loadImage(url: urlReq)
        }
        
        return nil
        
    }
    
    static func decode(_ data:Data){
        let root:Level1 = try! JSONDecoder().decode(Level1.self, from: data)
        //print(root.data.children)
        
        for item in root.data.children{
            var add = true
            for j in PersistenceManager.resData{
                if( item.data.author == j.author && item.data.title == j.title){
                    add = false
                    break
                }
            }
            if(add){
                HTTPRequester.getRequest(item.data.url+".json",completionHandler: { ( dataComments) -> Void in
                    var comments:[Comment] = []
                    if let dataCorrect = dataComments{
                        print(item.data.title)
                        comments = decodeComments(dataCorrect)
                    }
                    PersistenceManager.resData.append(PostStr(author: item.data.author, domain: item.data.domain, created: item.data.created.description, title: item.data.title, numComments: item.data.numComments.description, ups: item.data.ups.description, downs: item.data.downs.description, thumbnail: item.data.thumbnail, saved: false, url: item.data.url, comments: comments))
                    
                })
                
                
            }
        }
        
        
        //        PersistenceManager.res = PostStr(author: root.data.children.data.author, domain: root.data.children.data.domain, created: root.data.children.data.created.description, title: root.data.children.data.title, numComments: root.data.children.data.numComments.description, ups: root.data.children.data.ups.description, downs: root.data.children.data.downs.description, thumbnail: root.data.children.data.thumbnail)
    }
    static func decodeComments(_ data:Data) ->[Comment]{
        
        let welcome:[Comment1] = try! JSONDecoder().decode(Array<Comment1>.self, from: data)
        var res:[Comment] = []
        for item in welcome[1].data.children{
            if item.data.author != "[deleted]" && item.data.body! != "[deleted]"{
                res.append(item.data)
            }
            
            
            if let comms = item.data.replies{
                
                res.append(contentsOf: replies(comms))
            }
        }
        
        return res
    }
    static func replies(_ data:Comment1) ->[Comment]{
        var res:[Comment] = []
        for i in data.data.children{
            if i.data.author != "[deleted]" && i.data.body! != "[deleted]"{
                res.append(i.data)
            }
            
            if let comms = i.data.replies{
                
                res.append(contentsOf: replies(comms))
            }
        }
        
        return res
    }
}
