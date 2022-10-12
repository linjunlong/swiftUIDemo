//
//  ContentView.swift
//  06.State
//
//  Created by junlong lin on 2022/8/31.
//

import SwiftUI

struct ContentView: View {
    // 定义变量
        @State var isSelected = false
        var body: some View {
            VStack {
                Button(action: {
                    self.isSelected.toggle()
                }) {
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 150))
                        .foregroundColor(isSelected ? Color(red: 112 / 255, green: 182 / 255, blue: 3 / 255) : Color(red: 170 / 255, green: 170 / 255, blue: 170 / 255))
                }
                
                //文字
                titleView(isSelected: $isSelected)
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct titleView: View {
    //绑定状态
    @Binding var isSelected: Bool
    var body: some View {
        Text(isSelected ? "已开启" :"未开启")
            .fontWeight(.bold)
            .font(.system(size: 17))
            .padding()
    }
}
