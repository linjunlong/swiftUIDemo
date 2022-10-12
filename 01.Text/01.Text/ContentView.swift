//
//  ContentView.swift
//  01.Text
//
//  Created by junlong lin on 2022/8/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
        .fontWeight(.bold)
        .font(.system(size: 17))
        .foregroundColor(.blue)
        .shadow(color: Color.black, radius: 10)    //设置阴影
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
