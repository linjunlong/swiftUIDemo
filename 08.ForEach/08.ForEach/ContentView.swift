//
//  ContentView.swift
//  08.ForEach
//
//  Created by junlong lin on 2022/8/31.
//

import SwiftUI
struct Message : Identifiable {
    var id = UUID()
    var name: String
    var image: String
}

// 定义数组，存放数据
    var Messages = [
        Message(name: "这是微信", image: "weixin"),
        Message(name: "这是陌陌", image: "momo"),
        Message(name: "这是QQ", image: "qq"),
        Message(name: "这是淘宝", image: "taobao"),
        Message(name: "这是拼多多", image: "pinduoduo")
    ]

struct ContentView: View {
    var body: some View {
        // 简单的列表
        List(Messages) { Message in
            HStack {
                Image(Message.image)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .cornerRadius(5)
                Text(Message.name)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
