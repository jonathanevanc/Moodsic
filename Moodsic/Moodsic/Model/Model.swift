//
//  Model.swift
//  Moodsic
//
//  Created by Jonathan Evan Christian on 24/05/23.
//

import Foundation

struct HeartRate: Identifiable {
    let id = UUID()
    var heartRate: Int
    let date: Date
}
