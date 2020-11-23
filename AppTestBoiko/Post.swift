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
    let children: [Level3]
    enum Children: String, CodingKey {
        case children
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Children.self)
        children = try container.decode(Array<Level3>.self, forKey: .children)
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
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case numComments = "num_comments"
        case domain
        case author
        case created
        case title
        case thumbnail
        case ups
        case downs
        case url
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
        url = try container.decode(String.self, forKey: .url)
    }
}
struct PostStr: Codable{
    var author: String = ""
    var domain: String = ""
    var created: String = ""
    var title: String = ""
    var numComments: String = ""
    var ups: String = ""
    var downs: String = ""
    var thumbnail: String = ""
    var saved: Bool = false
    var url: String = ""
    var description: String {
        return """
        Author: \(author), domain: \(domain), created: \(created), title: \(title), numComments: \(numComments), ups: \(ups), downs: \(downs), thumbnail: \(thumbnail), saved \(saved)
        """
    }
    enum CodingKeys: String, CodingKey {
        case author
        case domain
        case created
        case title
        case numComments
        case ups
        case downs
        case thumbnail
        case saved
        case url
      }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(author, forKey: .author)
        try container.encode(domain, forKey: .domain)
        try container.encode(created, forKey: .created)
        try container.encode(title, forKey: .title)
        try container.encode(numComments, forKey: .numComments)
        try container.encode(ups, forKey: .ups)
        try container.encode(downs, forKey: .downs)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(saved, forKey: .saved)
        try container.encode(url, forKey: .url)
      }
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try container.decode(String.self, forKey: .author)
        domain = try container.decode(String.self, forKey: .domain)
        created = try container.decode(String.self, forKey: .created)
        title = try container.decode(String.self, forKey: .title)
        numComments = try container.decode(String.self, forKey: .numComments)
        ups = try container.decode(String.self, forKey: .ups)
        downs = try container.decode(String.self, forKey: .downs)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        saved = try container.decode(Bool.self, forKey: .saved)
        url = try container.decode(String.self, forKey: .url)
      }
    init(author: String, domain: String, created: String, title: String, numComments: String, ups: String, downs: String, thumbnail: String, saved: Bool, url: String){
        self.author = author
        self.domain = domain
        self.created = created
        self.title = title
        self.numComments = numComments
        self.ups = ups
        self.downs = downs
        self.thumbnail = thumbnail
        self.saved = saved
        self.url = url
    }
    
}
struct Post {
    var author: String = ""
    var domain: String = ""
    var created: Date = Date()
    var createdStr: String = ""
    var title: String = ""
    var numComments: Int = 0
    var ups: Int = 0
    var downs: Int = 0
    var thumbnail: String = ""
    var image: Data? = nil
    var saved: Bool = false
    var url: String = ""
    var description: String {
        return """
        Author: \(author), domain: \(domain), created: \(created), title: \(title), numComments: \(numComments), ups: \(ups), downs: \(downs), thumbnail: \(thumbnail), saved \(saved)
        """
    }
}
