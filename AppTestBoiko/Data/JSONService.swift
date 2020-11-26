//
//  JSONService.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 15.11.2020.
//

import Foundation

class JSONService{
    private static let filename = getDocumentsDirectory().appendingPathComponent("savedPosts.txt")
    private static let filenameImage = getDocumentsDirectory().appendingPathComponent("savedImages.txt")
    static func loadSaved(){
        do {
            let text2 = try String(contentsOf: filename, encoding: .utf8)
            let data = text2.data(using: .utf8)!
            let res: [PostStr] = try! JSONDecoder().decode(Array<PostStr>.self, from: data)
            // let res: [PostStr] = []
            for item in res{
                var add = true
                for j in PersistenceManager.resData{
                    if( item.author == j.author && item.title == j.title){
                        add = false
                        Repository.updateSavedPost(title: item.title)
                        break
                    }
                }
                if(add){
                    
                    PersistenceManager.resData.append(PostStr(author: item.author, domain: item.domain, created: item.created.description, title: item.title, numComments: item.numComments.description, ups: item.ups.description, downs: item.downs.description, thumbnail: item.thumbnail, saved: true, url: item.url, comments: item.comments))
                    
                }
            }
            
        }
        catch {}
        
    }
    static func loadImage(title:String)->Data?{
        //print("Repository load Image")
        do {
            let text2 = try String(contentsOf: filenameImage, encoding: .utf8)
            let data = text2.data(using: .utf8)!
            let res: [Image] = try! JSONDecoder().decode(Array<Image>.self, from: data)
            
            for item in res{
                if item.title == title{
                    return item.image
                }
            }
            
        }
        catch {}
        return nil
    }
    
    static func save(arr: [PostStr], images:[Image]){
        
        let data = try? JSONEncoder().encode(arr)
        do {
            try data?.write(to: filename)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
        let dataImage = try? JSONEncoder().encode(images)
        do {
            try dataImage?.write(to: filenameImage)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
        
        
    }
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
