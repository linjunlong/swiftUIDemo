//
//  ContentView.swift
//  03.Stack
//
//  Created by junlong lin on 2022/8/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // 定价方案
        VStack {
            // 标题
            titleView()
            
            // 定价方案
            HStack {
                // 连续包月
                ZStack {
                    pricingView(title: "连续包月", price: "¥18", perPrice: "", bgColor:  Color(red: 244 / 255, green: 244 / 255, blue: 245 / 255))
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color(red: 202 / 255, green: 169 / 255, blue: 106 / 255), lineWidth: 2))
                    // 首月特惠
                     specialOfferView()
                }
                // 1个月
                pricingView(title: "1个月", price: "¥30", perPrice: "", bgColor: Color(red: 244 / 255, green: 244 / 255, blue: 245 / 255))
                    .cornerRadius(10)
                // 12个月
                pricingView(title: "12个月", price: "¥228", perPrice: "¥19.00/月", bgColor: Color(red: 244 / 255, green: 244 / 255, blue: 245 / 255))
                    .cornerRadius(10)
                }
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct titleView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("会员套餐")
                    .fontWeight(.bold)
                    .font(.system(.title))
                Text("解锁高级功能")
                    .fontWeight(.bold)
                    .font(.system(.title))
            }
            
            //间隔符
            Spacer()
        }
        .padding()
    }
}

//定价方案子视图
struct pricingView: View {
    // 定义变量
    var title: String
    var price: String
    var perPrice: String
    var bgColor: Color
    var body: some View {
        VStack {
            Text(title)
                .fontWeight(.bold)
                .font(.system(size: 17))
                .foregroundColor(Color(red: 190 / 255, green: 188 / 255, blue: 184 / 255))
            Text(price)
                .fontWeight(.bold)
                .font(.system(size: 28))
                .foregroundColor(Color(red: 239 / 255, green: 129 / 255, blue: 112 / 255))
            Text(perPrice)
                .fontWeight(.bold)
                .font(.system(size: 15))
                .foregroundColor(Color(red: 190 / 255, green: 188 / 255, blue: 184 / 255))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 90)
        .padding(20)
        .background(bgColor)
    }
}

struct specialOfferView: View {
    var body: some View {
        Text("首月特惠")
            .font(.system(size: 14))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(5)
            .background(Color(red: 202 / 255, green: 169 / 255, blue: 106 / 255))
            .cornerRadius(4)
            .offset(x: 0, y: -65)
    }
}
