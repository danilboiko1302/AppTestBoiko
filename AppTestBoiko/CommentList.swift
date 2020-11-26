//
//  CommentList.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 25.11.2020.
//

import SwiftUI

struct CommentList: View {
    init(comments: [Comment]) {
        self.comments = comments
        // 1.
        UINavigationBar.appearance().backgroundColor = .systemGray3
        UINavigationBar.appearance().barTintColor = .systemGray3
        // 2.
        
    }
    var comments: [Comment]
    var body: some View {
        NavigationView {
            List {
                ForEach(comments, id: \.body) { comment in
                    
                    
                    NavigationLink(destination: CommentDetails(comment: comment)) {
                        HStack {
                            Spacer()
                            CommentRow(comment: comment)
                            Spacer()
                        }
                    }
                    
                    
                    
                    Spacer()
                }.listRowBackground(Color.init(UIColor.systemGray3))
            }.listRowBackground(Color.init(UIColor.systemGray3))
            .navigationBarTitle(Text("Comments"))
        }
        
        
    }
}

struct CommentList_Previews: PreviewProvider {
    static var previews: some View {
        
        CommentList(comments: [Comment(author: "author", body: "Hellosdadbasjkdgsfk asf haskfkasfk", created: 13213123, score: 32),Comment(author: "author", body: "Hellosdadbasjkdgsfk asf haskfkasfk", created: 13213123, score: 32)])
    }
}
