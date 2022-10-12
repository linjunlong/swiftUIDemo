//
//  _5_CoreDataApp.swift
//  15.CoreData
//
//  Created by junlong lin on 2022/9/2.
//

import SwiftUI

@main
struct _5_CoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
