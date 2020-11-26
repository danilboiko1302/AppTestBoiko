//
//  CommentRow.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 25.11.2020.
//

import SwiftUI

struct CommentRow: View {
    var comment: Comment
    func time(time:Int)->String{
        var timeInterval = Date(timeIntervalSince1970: TimeInterval(time)).timeIntervalSinceNow
        var timeStr = ""
        if(timeInterval < 0 ){
            timeInterval = -timeInterval
        }
        
        if(timeInterval < 60){
            timeStr = "\(Int(timeInterval)) secs"
        } else if(timeInterval < 3600){
            timeStr = "\(Int(timeInterval/60)) mins"
        }  else if(timeInterval < (3600 * 24)){
            timeStr = "\(Int(timeInterval/3600)) hours"
        } else if(timeInterval < (3600  * 24*7)){
            timeStr = "\(Int(timeInterval/3600/24)) days"
        } else if(timeInterval < (2592000)){
            timeStr = "\(Int(timeInterval/3600/24/7)) weeks"
        } else if(timeInterval < (31556926)){
            timeStr = "\(Int(timeInterval/3600/24/7/4)) months"
        } else {
            timeStr = "\(Int(timeInterval/3600/24/7/4/12)) years"
        }
        return timeStr
    }
    var body: some View {
        
        VStack{
            HStack {
                
                Text(comment.author).foregroundColor(Color.init(UIColor.label)).multilineTextAlignment(.center)
                Text(time(time: comment.created)).foregroundColor(Color.init(UIColor.label)).multilineTextAlignment(.center)
                Text("\u{1F44D}"+String(comment.score)).foregroundColor(Color.init(UIColor.label)).multilineTextAlignment(.center)
            }.multilineTextAlignment(.center)
            Spacer()
            
            Text(comment.body ?? "123").foregroundColor(Color.init(UIColor.label))
                .multilineTextAlignment(.center)
        }.multilineTextAlignment(.center)
        
        
        
        
        
        
        
    }
}

struct CommentRow_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CommentRow(comment: Comment(author: "author", body: "Hellosdadbasjkdgsfk asf haskfkasfk", created: 13213123, score: 32))
            CommentRow(comment: Comment(author: "author", body: "Hellosdadbasjkdgsfk asf haskfkasfk", created: 13213123, score: 32))
        }.previewLayout(.fixed(width: 300, height: 150))
        
        
    }
}
