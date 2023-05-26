//
//  OnboardingView.swift
//  Moodsic
//
//  Created by Jonathan Evan Christian on 25/05/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var onboarded : Bool
    
    var body: some View {
        VStack (alignment: .center){
            Text("Welcome to\nMoodSic")
                .multilineTextAlignment(.center)
                .font(.title)
                .bold()
                .padding(.top, 100)
                .padding(.bottom, 20)
            Image("Moodsic White")
                .resizable()
                .frame(width:300, height: 300)
                .padding(.bottom, 40)
            Text("We match your music with your mood.")
                .foregroundColor(.primary)
                .padding(.bottom, 100)
                .font(.title3)
            Text("tap anywhere to continue")
                .foregroundColor(.secondary)
                .font(.caption)
            Spacer()
            Text("This app requires access to your Health Data")
                .foregroundColor(.primary)
                .font(.caption)
            
        }
        .onTapGesture {
            onboarded = true
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onboarded: .constant(false)).preferredColorScheme(.dark)
    }
}
