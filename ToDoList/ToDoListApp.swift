//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Ross Morton on 29/07/2025.
//

import SwiftUI
import SwiftData

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .modelContainer(for: ToDo.self)
        }
    }
    // Allows us to locate Simulator Data
    init()  {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
