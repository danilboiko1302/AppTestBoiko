//
//  SwiftUIView.swift
//  AppTestBoiko
//
//  Created by Данило Бойко on 25.11.2020.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack {
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).foregroundColor(.red)
                .background(Color.init(UIColor.systemGray3))
            Text("Hello, World!").foregroundColor(.red)
                .background(Color.init(UIColor.systemGray3))
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).foregroundColor(.red)
                .background(Color.init(UIColor.systemGray3))
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).foregroundColor(.red)
                .background(Color.init(UIColor.systemGray3))
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).foregroundColor(.red)
                .background(Color.init(UIColor.systemGray3))
        }
            
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
