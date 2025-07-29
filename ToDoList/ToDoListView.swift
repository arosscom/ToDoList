//
//  ToDoListtView.swift
//  ToDoList
//
//  Created by Ross Morton on 29/07/2025.
//

import SwiftUI

struct ToDoListView: View {
    
    var toDos = ["Buy milk", "Learn SwiftUI", "Go for a walk", "Take a Vacation", "Learn SwiftData"]
    
    var body: some View {
        
        NavigationStack {
            List {
                
                ForEach(toDos, id: \.self) { toDo in
                    NavigationLink {
                        DetailView(passedValue: toDo)                   }label: {
                            Text(toDo)
                        }
                }
                .navigationTitle(Text("To Do List "))
                .navigationBarTitleDisplayMode(.automatic)
                .listStyle(.plain)
            }
        }
    }
}

#Preview {
    ToDoListView()
}
