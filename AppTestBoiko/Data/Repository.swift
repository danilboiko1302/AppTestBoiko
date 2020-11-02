//
//  Repository.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 02.11.2020.
//

import Foundation
class Repository{
    
    static func requestForUpdate(){
        print("I am Repository, I need to update information in PersistenceManager, HTTPServise will help me.")
        HTTPService.getRequest(url: "https://www.reddit.com", params:["r","ios","top.json"],paramsKeyValue: ["limit":"1"])
        
    }
    static func update(){
        print("I am Repository, info in PersistenceManager changed, I need to send it back to UserCase.")
        UseCase.update(data: PersistenceManager.res)
    }
}


