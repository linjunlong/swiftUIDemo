//
//  SwiftUICoreDataApp.swift
//  SwiftUICoreData
//
//  Created by junlong lin on 2022/9/3.
//

import SwiftUI

@main
struct SwiftUICoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
