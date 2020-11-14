//
//  PersistenceManager.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 02.11.2020.
//

import Foundation
class PersistenceManager{
    static var count:Int = 0
    static var resData:[PostStr] = [] {
        didSet{
                Repository.updatePostArr()
        }
    }
    
   
}

