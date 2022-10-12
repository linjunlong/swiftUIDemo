//
//  ContentView.swift
//  10.Modal
//
//  Created by junlong lin on 2022/8/31.
//

import SwiftUI

struct ContentView: View {
    @State var showDetailView = false
    @State var showDetailView1 = false
        var body: some View {
            
            // 按钮
            VStack {
                Button(action: {
                    // 点击按钮跳转打开模态弹窗
                    self.showDetailView.toggle()
                }) {
                    // 按钮样式
                    Text("打开模态弹窗1")
                        .font(.system(size: 14))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
                        .cornerRadius(5)
                        .padding(.horizontal, 20)
                }
                .sheet(isPresented: $showDetailView) {
                    DetailView()
            }
                Button(action: {
                    // 点击按钮跳转打开模态弹窗
                    self.showDetailView1.toggle()
                }) {
                    // 按钮样式
                    Text("打开模态弹窗2")
                        .font(.system(size: 14))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
                        .cornerRadius(5)
                        .padding(.horizontal, 20)
                }
                .sheet(isPresented: $showDetailView1) {
                    DetailView1(showDetailView: $showDetailView1)
            }
            }
        }
}

// 方法1
// 详情页
struct DetailView: View {
    //定义环境变量
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            //主体内容
            Text("这是一个新页面1")
                .navigationBarItems(trailing: Button(action: {
                    // 点击按钮关闭弹窗
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.down.circle.fill")
                        .foregroundColor(.gray)
                }
            )
        }
    }
}

//方法2// 详情页
struct DetailView1: View {
    // 绑定参数
    @Binding var showDetailView: Bool
    @State var showAlert = false
    var body: some View {
        NavigationView {
            // 主体内容
            Button(action: {
                // 点击按钮打开警告弹窗
                self.showAlert.toggle()
            }) {
                Text("打开警告弹窗")
            }
            .alert(isPresented: $showAlert) {
                //Alerts结构体
//                Alert(title: Text("这是弹窗标题"), message: Text("这是弹窗的内容"), primaryButton: .default(Text("确定")), secondaryButton: .cancel(Text("取消")))
                Alert(
                    title: Text("Unable to Save Workout Data"),
                    message: Text("The connection to the server was lost."),
                    primaryButton: .default(
                        Text("Try Again"),
                        action: {
                            print("cancel")
                        }
                    ),
                    secondaryButton: .destructive(
                        Text("Delete"),
                        action: {
                            print("delete")
                        }
                    )
                )
            }
            
            
            .navigationBarItems(trailing: Button(action: {
                // 点击按钮关闭弹窗
                self.showDetailView.toggle()
            }) {
                Image(systemName: "chevron.down.circle.fill")
                    .foregroundColor(.gray)
            }
            )
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
