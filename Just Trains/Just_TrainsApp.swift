//
//  Just_TrainsApp.swift
//  Just Trains
//
//  Created by Reilly Freret on 2/19/23.
//

import SwiftUI

@main
struct Just_TrainsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
