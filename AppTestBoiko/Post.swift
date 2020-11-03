//
//  Post.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 02.11.2020.
//

import Foundation
struct Level1: Decodable {
    let data: Level2
    
    enum Data: String, CodingKey {
        case data
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Data.self)
        data = try container.decode(Level2.self, forKey: .data)
    }
}

struct Level2: Decodable {
    let children: Level3
    enum Children: String, CodingKey {
        case children
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Children.self)
        children = try container.decode(Array<Level3>.self, forKey: .children)[0]
    }
}

struct Level3: Decodable {
    let data: Level4
    
    enum Data: String, CodingKey {
        case data
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Data.self)
        data = try container.decode(Level4.self, forKey: .data)
    }
}

struct Level4: Decodable {
    let author: String
    let domain: String
    let created: TimeInterval
    let title: String
    let numComments: Int
    let ups: Int
    let downs: Int
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case numComments = "num_comments"
        case domain
        case author
        case created
        case title
        case thumbnail
        case ups
        case downs
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try container.decode(String.self, forKey: .author)
        domain = try container.decode(String.self, forKey: .domain)
        created = try container.decode(TimeInterval.self, forKey: .created)
        title = try container.decode(String.self, forKey: .title)
        numComments = try container.decode(Int.self, forKey: .numComments)
        ups = try container.decode(Int.self, forKey: .ups)
        downs = try container.decode(Int.self, forKey: .downs)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
    }
}
struct PostStr{
    var author: String = ""
    var domain: String = ""
    var created: String = ""
    var title: String = ""
    var numComments: String = ""
    var ups: String = ""
    var downs: String = ""
    var thumbnail: String = ""
    var saved: Bool = false
    var description: String {
        return """
        Author: \(author), domain: \(domain), created: \(created), title: \(title), numComments: \(numComments), ups: \(ups), downs: \(downs), thumbnail: \(thumbnail), saved \(saved)
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
    var saved: Bool = false
    var description: String {
        return """
        Author: \(author), domain: \(domain), created: \(created), title: \(title), numComments: \(numComments), ups: \(ups), downs: \(downs), thumbnail: \(thumbnail), saved \(saved)
        """
    }
}
