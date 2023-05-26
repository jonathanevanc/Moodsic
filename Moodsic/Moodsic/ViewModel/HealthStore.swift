//
//  HealthStore.swift
//  Moodsic
//
//  Created by Jonathan Evan Christian on 24/05/23.
//

import Foundation
import HealthKit

extension Date {
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

class HealthStore : ObservableObject {
    
    @Published var currHeartRate = 0.0
    @Published var averageHeartRate = 0.0
    @Published var volatility = 0.0
    @Published var currentVolatility = 0.0
    @Published var heartRates : [Double] = []
    
    var healthStore =  HKHealthStore()
    var query: HKStatisticsCollectionQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
            self.requestAuthorization { success in
                if success{
                    self.getHeartRateToday { heartRate in
                        //print("HEARTRATE --> \(heartRate)")
                        self.currHeartRate = heartRate
                    }
                }
            }
        }
    }
    
    func refreshHealthStore(){
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
            self.requestAuthorization { success in
                if success {
                    self.getHeartRateToday { heartRate in
                        //print("HEARTRATE --> \(heartRate)")
                        self.currHeartRate = heartRate
                        //print("CURR HEART RATE --> \(self.currHeartRate)")
                    }
                }
            }
        }
    }

    //dari dropbox
    func getHeartRateToday(completion: @escaping (Double) -> Void){
        let quantityTypeIdentifier = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let now = Date()
        //let startOfToday = Calendar.current.startOfDay(for: now)
        let startOfToday = Calendar.current.startOfDay(for: .distantPast)
        let predicate = HKQuery.predicateForSamples(withStart: startOfToday, end: now, options: .strictStartDate)
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
            query, samples, deletedObjects, queryAnchor, error in
            
            // 3
            guard let samples = samples as? [HKQuantitySample] else {
                completion(0)
                return
            }
            
            let heartRateQuantity = HKUnit(from: "count/min")
            var lastHeartRate = 0.0
            var averageHeartRate = 0.0
            
            for sample in samples {
                lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
                //print("---> last heart rate: \(lastHeartRate)")
                self.currHeartRate = lastHeartRate
                averageHeartRate = averageHeartRate + lastHeartRate
                self.heartRates.append(lastHeartRate)
            }
            
            func standardDeviation(data: [Double]) -> Double {
                let mean = data.reduce(0, +) / Double(data.count)
                let sumOfSquaredDifferences = data.reduce(0) { result, value in
                    let difference = value - mean
                    return result + difference * difference
                }
                let variance = sumOfSquaredDifferences / Double(data.count)
                return sqrt(variance)
            }
            
            self.volatility = standardDeviation(data: self.heartRates)
            self.currentVolatility = standardDeviation(data: self.heartRates.suffix(5))
            
            self.averageHeartRate = averageHeartRate / Double(samples.count)
            
            completion(lastHeartRate)
            
        }
        let query = HKAnchoredObjectQuery(type: quantityTypeIdentifier, predicate: predicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        
        query.updateHandler = updateHandler
        
        healthStore.execute(query)
    }
    
    func requestAuthorization(completion: @escaping (Bool)->Void){
        let typesToShare: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!
        ]

        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
            if success {
                completion(true)
            } else {
                print(error!.localizedDescription)
                completion(false)
            }
        }
    }
    
}
