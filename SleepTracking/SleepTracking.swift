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

    func requestAuthorization() {
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
                self.fetchSleepData()
            } else {
                print("HealthKit authorization failed. Error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    func fetchSleepData() {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            print("Sleep Analysis data type not available.")
            return
        }

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            if let sleepSamples = samples as? [HKCategorySample] {
                for sample in sleepSamples {
                    print("Sleep Analysis Sample:")
                    print("Start Date: \(sample.startDate)")
                    print("End Date: \(sample.endDate)")
                    print("Value: \(sample.value)")
                }
            } else {
                print("Error querying sleep data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }

        healthStore.execute(query)
    }
}

