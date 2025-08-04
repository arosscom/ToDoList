//
//  ToDoListtView.swift
//  ToDoList
//
//  Created by Ross Morton on 29/07/2025.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    
    @Query var toDos: [ToDo]
    
    @State private var sheetIsPresented: Bool = false
    
    @Environment(\.modelContext) private var modelContext
    
    
    var body: some View {
        
        NavigationStack {
            
            List {
                ForEach(toDos) { toDo in
                    HStack {
                        
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
                            .onTapGesture {
                                toDo.isCompleted.toggle()
                                guard let _ = try? modelContext.save() else {
                                    print("Error - Delete  on DetailView failed")
                                    return
                                }
                            }
                        NavigationLink {
                            DetailView(toDo: toDo)
                        } label: {
                            Text(toDo.item)
                        }
                     }
                    .font(.title2)
                }
                .onDelete { indexSet in
                    indexSet.forEach({ modelContext.delete(toDos[$0])})
                    guard let _ = try? modelContext.save() else {
                        print("Error - Delete  on DetailView failed")
                        return
                    }
                    //                    .swipeActions {                                   // alternative delete for single item
                    //                        Button("Delete", role: .destructive) {
                    //                            modelContext.delete(toDo)
                    //                            guard let _ = try? modelContext.save() else {
                    //                                print("Error - Delete  on DetailView failed")
                    //                                return
                    //                            }
                    //                        }
                    //                    }
                }
            }
            .navigationTitle(Text("To Do List "))
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .fullScreenCover(isPresented: $sheetIsPresented) {                                          // slides over a new black DetailView
                NavigationStack {
                    DetailView(toDo: ToDo())
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button  {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ToDoListView()
        .modelContainer(for: ToDo.self, inMemory: true)
    
}
