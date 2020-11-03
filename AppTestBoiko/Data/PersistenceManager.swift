//
//  PersistenceManager.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 02.11.2020.
//

import Foundation
class PersistenceManager{
    static var res:PostStr? = nil{
        didSet{
           // print("I am PersistenceManager, HTTPService updated info, I will give new info back to Repository.")
            print(res!.saved)
            Repository.updatePost()
        }
    }
    static var image:Data? = nil{
        didSet{
          //  print("Repository.updateImage()")
            Repository.updateImage()
        }
    }
}

