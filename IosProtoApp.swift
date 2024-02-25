//
//  IosProtoApp.swift
//  IosProto
//
//  Created by Nikolay Tsonev on 15/02/2024.
//

import SwiftUI

@main
struct IosProtoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
