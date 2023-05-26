//
//  HomeView.swift
//  Moodsic
//
//  Created by Jonathan Evan Christian on 22/05/23.
//

import Foundation
import SwiftUI
import HealthKit

struct HomeView: View {
    
    @StateObject var healthStore =  HealthStore()
    
    @Environment(\.openURL) var openURL
    
    @Binding var happy: String
    @Binding var relaxed: String
    @Binding var sad: String
    @Binding var anxious: String
    @Binding var angry: String
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading){

                Text("Current Mood")
                    .bold()
                    .font(.title3)
                    .foregroundColor(.primary)
    
                VStack {
                    ZStack {
                        VStack {
                            LottieViewComponent(name: "heartbeat", loopMode: .loop)
                        }
                        .frame(width: 358, height: 300)
                        
                        Text("\(Int(healthStore.currHeartRate))")
                            .font(.system(size: 56))
                            .offset(x: 0, y: 4)
                    }
                    .offset(x: 0, y: -15)
                    
                    Text("\(getMood())")
                        .font(.title)
                        .bold()
                        .offset(x: 0, y: -70)
                }
                .frame(width: 358, height: 250)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.secondary, lineWidth: 1)
                )
                .padding(.bottom, 10)
                
                Text("Summary")
                    .bold()
                    .font(.title3)
                    .foregroundColor(.primary)
                

                let titles: [(String, String)] = [
                    ("Current BPM", String(Int(healthStore.currHeartRate))),
                    ("Average BPM", String(Int(healthStore.averageHeartRate))),
                    ("Current Volatility", String(Int(healthStore.currentVolatility))),
                    ("Average Volatility", String(Int(healthStore.volatility)))
                ]
                
                List {
                    Section {
                        VStack(alignment: .center, spacing: 0){
                            ForEach(titles, id: \.0) { title in
                                let (key, value) = title
                                HStack {
                                    Text(key)
                                    Spacer()
                                    Text(value)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 10)
                                
                                Divider()
                                    .frame(width:340, height:1)
                                    .overlay(.secondary)
                            }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 8, style: .circular).stroke(.secondary, lineWidth: 1)
                        )
                    }
                    .frame(width: 358)
                }
                .listStyle(InsetListStyle())
                .scrollDisabled(true)
                .offset(x: 0, y: -12)
                
                VStack (alignment: .center){
                    Button {
                        openURL(URL(string: getLink())!)
                    } label: {
                        Text("Go to Spotify")
                            .font(.system(size: 24))
                            .frame(width:280, height: 40)
                        
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Text("Recommended playlist based on your current mood")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(width: 280)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 358)
                .offset(x:0, y:-40)
            }
            .padding(.horizontal,16)
            
            .navigationTitle("Hello, Jonathan!")
        }
        .onAppear {
            healthStore.refreshHealthStore()
            }
        }
    
    
    func getMood() -> String {
        let currentBPM = Double(healthStore.currHeartRate)
        let averageBPM = Double(healthStore.averageHeartRate)
        let currentVolatility = Double(healthStore.currentVolatility)
        let averageVolatility = Double(healthStore.volatility)
        
        //relaxed
        if (currentBPM < 0.85*averageBPM) && (currentVolatility < 0.8*averageVolatility) {
            return "Relaxed"
        //sad
        } else if (currentBPM < 0.9*averageBPM) && (currentVolatility > 1.25*averageVolatility) {
            return "Sad"
        //happy
        } else if (currentBPM > 1.1*averageBPM) && (currentVolatility < 0.9*averageVolatility) {
            return "Happy"
        //anxious
        } else if (currentBPM > 1.3*averageBPM) && (currentVolatility > 1.25*averageVolatility) {
            return "Anxious"
        //angry
        } else if (currentBPM > 1.5*averageBPM) && (currentVolatility > 1.5*averageVolatility) {
            return "Angry"
        } else {
            return "Normal"
        }
        
        //Relaxed: Heart rate is lower than average and the volatility is 0.5x of normal.
        //Sad: Heart rate is slightly lower than average and the volatility is 1.25x of normal.
        //Happy: Heart rate is slightly higher than average and the volatility is 0.75x of normal.
        //Anxious: Heart rate is higher than average and the volatility is 1.5x of normal.
        //Angry: Heart rate is significantly higher than average and the volatility is 2x of normal.
    }
    
    func getLink() -> String {
        let currentBPM = Double(healthStore.currHeartRate)
        let averageBPM = Double(healthStore.averageHeartRate)
        let currentVolatility = Double(healthStore.currentVolatility)
        let averageVolatility = Double(healthStore.volatility)
        
        //relaxed
        if (currentBPM < 0.85*averageBPM) && (currentVolatility < 0.8*averageVolatility) {
            return relaxed
        //sad
        } else if (currentBPM < 0.9*averageBPM) && (currentVolatility > 1.25*averageVolatility) {
            return sad
        //happy
        } else if (currentBPM > 1.1*averageBPM) && (currentVolatility < 0.9*averageVolatility) {
            return happy
        //anxious
        } else if (currentBPM > 1.3*averageBPM) && (currentVolatility > 1.25*averageVolatility) {
            return anxious
        //angry
        } else if (currentBPM > 1.5*averageBPM) && (currentVolatility > 1.5*averageVolatility) {
            return angry
        } else {
            return ""
        }
}
                                
                                }

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(happy: .constant("a"), relaxed: .constant("b"), sad: .constant("c"), anxious: .constant("d"), angry: .constant("e")).preferredColorScheme(.dark)
    }
}

