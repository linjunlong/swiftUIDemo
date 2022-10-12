//
//  NewToDoView.swift
//  SwiftUICoreData
//
//  Created by junlong lin on 2022/9/3.
//

import SwiftUI
import CoreData
struct NewToDoView: View {
    @State var name: String
    @State var isEditing = false
    @State var priority: Priority
    @Binding var showNewTask: Bool
    @Environment(\.managedObjectContext) var context
    var body: some View {
        VStack {
            Spacer()
            VStack {
                TopNavBar(showNewTask: $showNewTask)
                InputNameView(name: $name, isEditing: $isEditing)
                PrioritySelectView(priority: $priority)
                SaveButton(name: $name, showNewTask: $showNewTask, priority: $priority)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10, antialiased: true)
            .offset(y: isEditing ? -320 : 0)
        }.edgesIgnoringSafeArea(.bottom)
    }
}
struct NewToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NewToDoView(name: "", priority: .normal, showNewTask: .constant(true))
    }
}
// 顶部导航栏
struct TopNavBar: View {
    @Binding var showNewTask: Bool
    var body: some View {
        HStack {
            Text("新建事项")
                .font(.system(.title))
                .bold()
            Spacer()
            Button(action: {
                //关闭弹窗
                self.showNewTask = false
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .font(.title)
            }
        }
    }
}
//输入框
struct InputNameView: View {
    @Binding var name: String
    @Binding var isEditing: Bool
    var body: some View {
    
        TextField("请输入", text: $name, onEditingChanged: { (editingChanged) in
            self.isEditing = editingChanged
        })
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.bottom)
    }
}
// 选择优先级
struct PrioritySelectView: View {
    @Binding var priority: Priority
    var body: some View {
        HStack {
            PrioritySelectRow(name: "高", color: priority == .high ? Color.red : Color(.systemGray4))
                .onTapGesture { self.priority = .high }
            PrioritySelectRow(name: "中", color: priority == .normal ? Color.orange : Color(.systemGray4))
                .onTapGesture { self.priority = .normal }
                
            PrioritySelectRow(name: "低", color: priority == .low ? Color.green : Color(.systemGray4))
                .onTapGesture { self.priority = .low }
        }
    }
}
// 选择优先级
struct PrioritySelectRow: View {
    var name: String
    var color:Color
    var body: some View {
        Text(name)
            .frame(width: 80)
            .font(.system(.headline))
            .padding(10)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}
// 保存按钮
struct SaveButton: View {
    @Binding var name:String
    @Binding var showNewTask: Bool
    @Binding var priority:Priority
    @Environment(\.managedObjectContext) var context
    var body: some View {
        Button(action: {
            //判断输入框是否为空
            if self.name.trimmingCharacters(in: .whitespaces) == "" {
                return
            }
            //添加一条新数据
            self.addTask(name: self.name, priority: self.priority)
            //关闭弹窗
            self.showNewTask = false
        }) {
            Text("保存")
                .font(.system(.headline))
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
        }
        .padding([.top,.bottom])
    }
    //添加新事项方法
    private func addTask(name: String, priority: Priority, isCompleted: Bool = false) {
        let task = ToDoItem(context:context)
        task.id = UUID()
        task.name = name
        task.priority = priority
        task.isCompleted = isCompleted
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
