//
//  DetailView.swift
//  ToDoList
//
//  Created by Ross Morton on 29/07/2025.
//

import SwiftUI

struct DetailView: View {
 
    var passedValue: String
    
 //   @Environment(\.dismiss) private var dismiss                                         // needed to allow dismiss button
    
    var body: some View {
        VStack {
            
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
            
            Text("You are a Swifty Legend !\n Passed Value \(passedValue)")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
        }
        .padding()
//        .navigationBarBackButtonHidden(true)
        
        Spacer()
        
//        Button("Get Back") {
//            dismiss()
//        }
//        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    DetailView(passedValue: "0")
}
