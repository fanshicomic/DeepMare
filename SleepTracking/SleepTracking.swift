//
//  SleepTracking.swift
//  DeepMare
//
//  Created by Lin Fanshi on 9/12/23.
//

import Foundation
import HealthKit

class SleepDataFetcher {

    let healthStore = HKHealthStore()

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit is not available on this device.")
            return
        }

        let healthTypesToRead: Set<HKObjectType> = [
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthTypesToRead) { (success, error) in
            if success {
                print("HealthKit authorization granted.")
            } else {
                print("HealthKit authorization failed. Error: \(error?.localizedDescription ?? "Unknown error")")
            }
            
            completion(success)
        }
    }

    func fetchSleepData(completion: @escaping ([HKCategorySample], Error?) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            print("Sleep Analysis data type not available.")
            return
        }

        let endDate = Date()
        let startDate = Calendar.current.date(byAdding: .hour, value: -24, to: endDate)

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            if let sleepSamples = samples as? [HKCategorySample] {
                completion(sleepSamples, error)
            } else {
                print("Error querying sleep data: \(error?.localizedDescription ?? "Unknown error")")
                
                completion([], error)
            }
        }

        healthStore.execute(query)
    }
}

