//
//  ContentView.swift
//  06.Gradient
//
//  Created by junlong lin on 2022/8/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
    
        VStack {
            
            Button(action: {
                        // 操作
                        print("登录成功")
                    }) {
                        // 按钮样式
                        Text("微信登录自定义样式")
                            .font(.system(size: 14))
                    }
                    .buttonStyle(GradientBackgroundStyle())
            
            Button(action: {
                // 操作
                print("登录成功")
                }) {
                    // 按钮样式
                    Text("微信登录")
                        .font(.system(size: 14))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("8FD3F4"), Color("84FAB0")]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(5)
                        .padding(.horizontal, 20)
            }
        }
    }
}

//按钮修饰
struct GradientBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            // 按钮修饰符
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("8FD3F4"), Color("84FAB0")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(5)
            .padding(.horizontal, 20)
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
