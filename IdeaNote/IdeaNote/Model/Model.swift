//
//  Model.swift
//  IdeaNote
//
//  Created by superfly on 2023/5/29.
//
import Foundation
import SwiftUI
struct NoteModel: Identifiable,Codable {
    var id = UUID()
    var writeTime: String
    var title: String
    var content: String 
}

/*
class NoteItem: ObservableObject, Identifiable {
    var id = UUID()
    @Published var writeTime: String = ""
    @Published var title: String = ""
    @Published var content: String = ""
    
    // 实例化
    init(writeTime: String, title: String, content: String) {
        self.writeTime = writeTime
        self.title = title
        self.content = content
    }
}
*/

