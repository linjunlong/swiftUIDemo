//
//  ViewModel.swift
//  IdeaNote
//
//  Created by superfly on 2023/6/14.
//

import Foundation
import Combine
import SwiftUI

class ViewModel: ObservableObject {
    // 数据模型
    @Published var noteModels = [NoteModel]()
    
    // 笔记参数
    @Published var writeTime: String = ""
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var searchText = ""
    
    // 判断是否正在搜索
    @Published var isSearching: Bool = false
    
    // 判断是否新增
    @Published var isAdd: Bool = true
    
    // 打开新建笔记本弹窗
    @Published var showNewNoteView: Bool = false
    
    // 打开编辑笔记本弹窗
    @Published var showEditNoteView: Bool = false
    
    // 打开删除确认弹窗
    @Published var showActionSheet: Bool = false
    
    // 提示信息
    @Published var showToast = false
    @Published var showToastMessage: String = "提示信息"
    
    init() {
        loadItems()
        saveItems()
    }
    
    // 获取文档路径
    func documentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // 获取plist数据文件的路径
    func dataFilePath() -> URL {
        documentsDirectory().appendingPathComponent("IdeaNote.plist")
    }
    
    // 将数据写入本地缓存
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(noteModels)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error writing items to file: \(error.localizedDescription)")
        }
        
    }
    
    // 从本地缓存加载数据
    func loadItems () {
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                noteModels = try decoder.decode([NoteModel].self, from: data)
            } catch {
                print("Error reading items: \(error.localizedDescription)")
            }
        }
    }
    
    // 创建笔记
    func addItem(writeTime: String, title: String, content: String) {
        let newItem = NoteModel(writeTime: writeTime, title: title, content: content)
        noteModels.append(newItem)
        saveItems()
    }
    
    // 获得数据ID
    func getItemById(itemId: UUID) -> NoteModel?{
        return noteModels.first(where: {$0.id == itemId}) ?? nil
    }
    
    // 删除笔记
    func deleteItem(itemId: UUID) {
        noteModels.removeAll(where: {$0.id == itemId})
        saveItems()
    }
    
    // 编辑笔记
    func editItem(item: NoteModel) {
        if let id = noteModels.firstIndex(where: {$0.id == item.id}) {
            noteModels[id] = item
            saveItems()
        }
    }
    
    // 搜索笔记
    func searchContext() {
        let query = searchText.lowercased()
        DispatchQueue.global(qos: .background).async {
            let filter = self.noteModels.filter{$0.content.lowercased().contains(query)}
            DispatchQueue.main.async {
                self.noteModels = filter
            }
        }
    }
    
    // 获取当前时间
    func getCurrentTime() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY.MM.dd"
        return dateformatter.string(from: Date())
    }
    
    // 判断文字是否为空
    func isTextEmpty(text:String) -> Bool{
        if text == "" {
            return true
        } else {
            return false
        }
    }
    
}


