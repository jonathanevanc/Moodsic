//
//  SettingView.swift
//  Moodsic
//
//  Created by Jonathan Evan Christian on 22/05/23.
//

import SwiftUI
import CoreData

struct SettingView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var happy: String
    @Binding var relaxed: String
    @Binding var sad: String
    @Binding var anxious: String
    @Binding var angry: String
    
//    @StateObject private var coreDataManager = CoreDataManager.shared
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                Text("Set your playlist preferences based on your mood here")
                    .foregroundColor(.secondary)
                    .font(.body)
                    .padding(.bottom, 16)
                
                FormComponent(question: .constant("Happy"), answer: $happy)
                FormComponent(question: .constant("Relaxed"), answer: $relaxed)
                FormComponent(question: .constant("Sad"), answer: $sad)
                FormComponent(question: .constant("Anxious"), answer: $anxious)
                FormComponent(question: .constant("Angry"), answer: $angry)
                
                Spacer()
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingView(happy: .constant("a"), relaxed: .constant("b"), sad: .constant("c"), anxious: .constant("d"), angry: .constant("e"))
            .preferredColorScheme(.dark)
    }
}


