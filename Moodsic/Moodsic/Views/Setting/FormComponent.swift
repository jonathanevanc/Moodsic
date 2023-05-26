//
//  FormComponent.swift
//  Moodsic
//
//  Created by Jonathan Evan Christian on 22/05/23.
//

import SwiftUI

struct FormComponent: View {
    @Binding var question: String
    @Binding var answer: String
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(question)")
                .foregroundColor(.primary)
                .font(.title3)
                .bold()
                .padding(.bottom, -1)
            TextField("", text: $answer)
                .font(.body)
                .autocapitalization(.none)
                .padding(.horizontal, 12)
                .frame(width:358, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.secondary, lineWidth: 1)
                )
        }
        .frame(height:82)
    }
}

struct FormComponent_Previews: PreviewProvider {
    static var previews: some View {
        FormComponent(question: .constant("Mood type"), answer: .constant("www.spotify.com/blabla"))
    }
}
