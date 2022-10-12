//
//  ContentView.swift
//  SwiftUICoreData
//
//  Created by junlong lin on 2022/9/3.
//

import SwiftUI
import CoreData

import CoreData
import SwiftUI
struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest( entity: ToDoItem.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \ToDoItem.priorityNum, ascending: false) ])
    var todoItems: FetchedResults<ToDoItem>
    @State private var showNewTask = false
    @State private var offset: CGFloat = .zero    //使用.animation防止报错，iOS15的特性
    //去掉List背景颜色
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    var body: some View {
        ZStack {
        
            VStack {
                TopBarMenu(showNewTask: $showNewTask)
                List {
                    ForEach(todoItems) { todoItem in
                        ToDoListRow(todoItem: todoItem)
                    }.onDelete(perform: deleteTask)
                }
                }
            }
            //判断事项数量为0时展示缺省图
            if todoItems.count == 0 {
                NoDataView()
            }
            //点击添加时打开弹窗
            if showNewTask {
                //蒙层
                MaskView(bgColor: .black)
                    .opacity(0.5)
                    .onTapGesture {
                        self.showNewTask = false
                    }
                NewToDoView(name: "", priority: .normal, showNewTask: $showNewTask)
                    .transition(.move(edge: .bottom))
                    .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0),value: offset)
                }
        }
    
    //删除事项方法
    private func deleteTask(indexSet: IndexSet) {
        for index in indexSet {
            let itemToDelete = todoItems[index]
            context.delete(itemToDelete)
        }
        
        DispatchQueue.main.async {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
//蒙层
struct MaskView : View {
    var bgColor: Color
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
// 顶部导航栏
struct TopBarMenu: View {
    @Binding var showNewTask: Bool
    var body: some View {
        HStack {
            Text("待办事项")
                .font(.system(size: 40, weight: .black))
            Spacer()
            Button(action: {
                //打开弹窗
                self.showNewTask = true
            }) {
            
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle).foregroundColor(.blue)
            }
        }
        .padding()
    }
}
// 缺省图
struct NoDataView: View {
    var body: some View {
        Image("image01")
            .resizable()
            .scaledToFit()
    }
}

// 列表内容
struct ToDoListRow: View {
    @ObservedObject var todoItem: ToDoItem
    @Environment(\.managedObjectContext) var context
    var body: some View {
        Toggle(isOn: self.$todoItem.isCompleted) {
            HStack {
                Text(self.todoItem.name)
                    .strikethrough(self.todoItem.isCompleted, color: .black)
                    .bold()
                    .animation(.default)
                Spacer()
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundColor(self.color(for: self.todoItem.priority))
            }
        }.toggleStyle(CheckboxStyle())
        //监听todoItem数组参数变化并保存
        .onReceive(todoItem.objectWillChange, perform: { _ in
            if self.context.hasChanges {
                try? self.context.save()
            }
        })
    }
    // 根据优先级显示不同颜色
    private func color(for priority: Priority) -> Color {
        switch priority {
        case .high:
            return .red
        case .normal:
            return .orange
        case .low:
            return .green
        }
    }
}
// checkbox复选框样式
struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .purple : .gray)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}
