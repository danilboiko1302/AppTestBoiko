//
//  CommentList.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 25.11.2020.
//

import SwiftUI

struct CommentList: View {
    var comments: [Comment]
    var body: some View {
       
       
        
            
            List {
                        ForEach(comments, id: \.author) { comment in
                            CommentRow(comment: comment)
                            Spacer()
                        }.listRowBackground(Color.init(UIColor.systemGray3))
                    }.listRowBackground(Color.init(UIColor.systemGray3))
           
        
        
                
            
           
        
                
      
       
    }
}

struct CommentList_Previews: PreviewProvider {
    static var previews: some View {
        
        CommentList(comments: [])
    }
}
