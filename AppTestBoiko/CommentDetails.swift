//
//  CommentDetails.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 27.11.2020.
//

import SwiftUI

struct CommentDetails: View {
    var comment: Comment
    var body: some View {
        ZStack {
            Color.init(UIColor.systemGray3)
            VStack{
                HStack{
                    Text(comment.author).foregroundColor(Color.init(UIColor.label)).multilineTextAlignment(.center)
                    Text(time(time: comment.created)).foregroundColor(Color.init(UIColor.label)).multilineTextAlignment(.center)
                }
                HStack{
                    Spacer()
                    ScrollView{
                        Text(comment.body ?? "123").foregroundColor(Color.init(UIColor.label))
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                }
                Text("Rating: "+String(comment.score)).foregroundColor(Color.init(UIColor.label)).multilineTextAlignment(.center)
                Spacer()
                Button(action: {
                    AppTestBoiko.actionSheet(comment.permalink)
                }) {
                    Text("Share")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.blue)
                }
            }
            Spacer()
        }.navigationBarTitleDisplayMode(.inline)
        
    }
}
func actionSheet(_ url:String) {
    guard let data = URL(string: url) else { return }
    let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
}

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



struct CommentDetails_Previews: PreviewProvider {
    static var previews: some View {
        CommentDetails(comment: Comment(author: "", body: "", created: 1, score: 1))
    }
}
