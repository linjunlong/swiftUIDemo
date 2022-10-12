//
//  ContentView.swift
//  12.editList
//
//  Created by junlong lin on 2022/9/1.
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
    // 定义数组
    @State var messagesItems = Messages
    @State var showActionSheet = false
    var body: some View {
        NavigationView {
            // 列表
            List {
                ForEach(messagesItems) { Message in
                    HStack {
                        Image(Message.image)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(5)
                        Text(Message.name)
                            .padding()
                    }
                    // 上下文菜单
                    .contextMenu {
                        Button(action: {
                            // 点击打开ActionSheet弹窗
                            self.showActionSheet.toggle()
                        }) {
                            HStack {
                                Text("删除")
                                Image(systemName: "trash")
                            }
                        }
                    }
                    // ActionSheet弹窗
                    .actionSheet(isPresented: self.$showActionSheet) {
                        ActionSheet(
                            title: Text("你确定要删除此项吗？"),
                            message: nil,
                            buttons: [
                                .destructive(Text("删除"), action: {
                                    //点击删除
                                    self.delete(item: Message)
                                }),
                                .cancel(Text("取消"))
                            ])
                    }
                }
                .onDelete(perform: deleteRow)
                .onMove(perform: moveItem)
            }.navigationBarItems(trailing: EditButton())
        }
    }
    // 删除的方法
    func delete(item Message: Message) {
        if let index = messagesItems.firstIndex(where: { $0.id == Message.id }) {
            messagesItems.remove(at: index)
        }
    }
    // 滑动删除方法
    func deleteRow(at offsets: IndexSet) {
        messagesItems.remove(atOffsets: offsets)
    }
    // 拖动排序方法
    func moveItem(from source: IndexSet, to destination: Int) {
        messagesItems.move(fromOffsets: source, toOffset: destination)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
