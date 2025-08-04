//
//  DetailView.swift
//  ToDoList
//
//  Created by Ross Morton on 29/07/2025.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    
    @State var toDo: ToDo
    @State private var item = ""
    @State private var reminderIsOn = true
    @State private var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
    @State private var notes = ""
    @State private var isCompleted = false
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        List {
            TextField("Enter To Do Here", text: $item)
                .font(.title)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
                .listRowSeparator(.hidden)
            
            Toggle("Set Reminder:", isOn: $reminderIsOn )
                .padding(.top)
                .listRowSeparator(.hidden)
            
            DatePicker("Date:", selection: $dueDate)
                .listRowSeparator(.hidden)
                .padding(.bottom )
                .disabled(!reminderIsOn)
            
            Text("Notes")
                .padding(.top)
            TextField("Notes", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .listRowSeparator(.hidden)
            
            Toggle("Completed", isOn: $isCompleted )
                .padding(.top)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .onAppear() {
            item = toDo.item
            reminderIsOn = toDo.reminderIsOn
            dueDate = toDo.dueDate
            notes = toDo.notes
            isCompleted = toDo.isCompleted
        }
        
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                    print("Cancel Tapped  ")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {                                                                       // move data from local vars to toDo object
                    toDo.item = item
                    toDo.reminderIsOn = reminderIsOn
                    toDo.dueDate = dueDate
                    toDo.notes = notes
                    toDo.isCompleted = isCompleted
                    modelContext.insert(toDo)                                                          // save the data
                    guard let _ = try? modelContext.save() else {
                        print("Error - Save on DetailView failed")
                        return
                    }
                    dismiss()
                    print("Data Saved")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(toDo: ToDo(item: "A", isCompleted: false))
            .modelContainer(for: ToDo.self, inMemory: true)
    }

}
