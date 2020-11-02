//
//  HTTPService.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 02.11.2020.
//

import Foundation
class HTTPService{
    static func getRequest(url:String, params:[String] = [], paramsKeyValue:[String:String] = [:]) {
        print("I am HTTPService, I need to create request and HTTPRequest will send it.")
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
                print("I am HTTPService, I got new data from HTTPRequest, I will parse it and update it in PersistenceManager.")
                decode(data)
            }
        })
        
    }
    static func decode(_ data:Data){
        let root:Level1 = try! JSONDecoder().decode(Level1.self, from: data)
        PersistenceManager.res = PostStr(author: root.data.children.data.author, domain: root.data.children.data.domain, created: root.data.children.data.created.description, title: root.data.children.data.title, numComments: root.data.children.data.numComments.description, ups: root.data.children.data.ups.description, downs: root.data.children.data.downs.description, thumbnail: root.data.children.data.thumbnail)
    }
}
