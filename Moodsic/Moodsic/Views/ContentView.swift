//
//  ContentView.swift
//  Moodsic
//
//  Created by Jonathan Evan Christian on 22/05/23.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    @State private var happy: String = "https://open.spotify.com/playlist/0RH319xCjeU8VyTSqCF6M4"
    @State private var relaxed: String = "https://open.spotify.com/artist/7vgzPGibRcse3QY4d9316n"
    @State private var sad: String = "https://open.spotify.com/playlist/3xW83p7ttFJGBJaB5uW7dG"
    @State private var anxious: String = "https://open.spotify.com/playlist/1FfRMu8RvRjxYqkb0YmKbQ"
    @State private var angry: String = "https://open.spotify.com/playlist/609gQW5ztNwAkKnoZplkao"
        
    @State var onboarded : Bool = false
    
    var body: some View {
        
        if onboarded {
            TabView {
                HomeView(happy: $happy, relaxed: $relaxed, sad: $sad, anxious: $anxious, angry: $angry)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                SettingView(happy: $happy, relaxed: $relaxed, sad: $sad, anxious: $anxious, angry: $angry)
                    .tabItem {
                        Label("Setting", systemImage: "gearshape.fill")
                    }
            }
        } else {
            OnboardingView(onboarded: $onboarded)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
