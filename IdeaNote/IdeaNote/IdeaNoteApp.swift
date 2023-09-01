//
//  IdeaNoteApp.swift
//  IdeaNote
//
//  Created by superfly on 2023/5/29.
//

import SwiftUI

@main
struct IdeaNoteApp: App {
    
    @StateObject var viewModel:ViewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)
        }
    }
}
