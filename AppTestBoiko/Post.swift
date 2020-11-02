//
//  Post.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 02.11.2020.
//

import Foundation
struct PostStr{
    var author: String = ""
    var domain: String = ""
    var created: String = ""
    var title: String = ""
    var numComments: String = ""
    var ups: String = ""
    var downs: String = ""
    var thumbnail: String = ""
    var description: String {
        return """
        Author: \(author), domain: \(domain), created: \(created), title: \(title), numComments: \(numComments), ups: \(ups), downs: \(downs), thumbnail: \(thumbnail)
        """
    }
}
struct Post {
    var author: String = ""
    var domain: String = ""
    var created: Date = Date()
    var title: String = ""
    var numComments: Int = 0
    var ups: Int = 0
    var downs: Int = 0
    var thumbnail: String = ""
    var description: String {
        return """
        Author: \(author), domain: \(domain), created: \(created), title: \(title), numComments: \(numComments), ups: \(ups), downs: \(downs), thumbnail: \(thumbnail)
        """
    }
}
