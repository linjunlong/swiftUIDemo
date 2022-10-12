//
//  ContentView.swift
//  05.Button
//
//  Created by junlong lin on 2022/8/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            buttonView(title: "微信登录", bgColor: Color(red: 88 / 255, green: 224 / 255, blue: 133 / 255),iconImage: "")
        buttonView(title: "Apple登录", bgColor: Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255),iconImage: "applelogo")
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//按钮

struct buttonView: View {

    //定义变量
    var title: String
    var bgColor: Color
    var iconImage : String

    var body: some View {
        Button(action: {

            // 操作
            print("登录成功")

        }) {
            HStack {
            if !iconImage.isEmpty {
                Image(systemName: iconImage)
                .font(.title)
            }
            // 按钮样式
            Text(title)
                .fontWeight(.semibold)
                .font(.title)
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.white)
                .background(bgColor)
                .cornerRadius(40)
                .padding(.horizontal, 20)
        }
    }
}
