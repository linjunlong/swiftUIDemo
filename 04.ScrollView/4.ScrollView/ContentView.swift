//
//  ContentView.swift
//  4.ScrollView
//
//  Created by junlong lin on 2022/8/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                // 卡片
                cardView(image: "charleyrivers", title: "你的能力是否能在全世界通用，如果不能,那么需求重新评估你的能力。")
                cardView(image: "chilkoottrail", title: "当你判断你的想法是正确的，那么就在今天完成吧。")
                cardView(image: "chincoteague", title: "将自身所学回馈社会，，不也是一件幸福的事么。")
                cardView(image: "hiddenlake", title: "成功的秘诀是，绝对不要和别人做同样的事情。")
            }
        }
    }
}

struct cardView: View {

    //定义变量
    var image:  String
    var title: String

    var body: some View {
        VStack {
        
            // 图片
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)

            // 文字
            Text(title)
                .font(.system(size: 17))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()
        }
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10) .stroke(Color(red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1))
        .padding([.top, .horizontal])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
