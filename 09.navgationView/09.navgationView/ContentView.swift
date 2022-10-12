//
//  ContentView.swift
//  09.navgationView
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
        //导航栏
        NavigationView {
        // 简单的列表
            List(Messages) { Message in
                NavigationLink(destination: DetailView(message: Message)) {
                    HStack {
                        Image(Message.image)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(5)
                        Text(Message.name)
                    }
                }
            }.navigationBarTitle("我是标题", displayMode: .automatic)
        }
    }
}

//详情页面
struct DetailView: View {
    //环境值
    @Environment(\.presentationMode) var mode
    var message: Message
    var body: some View {
        VStack {
            Image(message.image)
                .resizable()
                .frame(width: 80, height: 80)
            Text(message.name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            // 点击按钮后的操作
            self.mode.wrappedValue.dismiss()
            }){
            //按钮及其样式
            Image(systemName: "chevron.left")
                .foregroundColor(.gray)
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
