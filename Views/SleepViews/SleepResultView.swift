//
//  SleepResultView.swift
//  DeepMare
//
//  Created by Mingyu Lei on 2023/12/09.
//

import SwiftUI
import HealthKit

struct SleepResultView: View {
    let sleepDataFetcher = SleepDataFetcher()
    @State var sleepData: [HKCategorySample] = []
    @State var message: String = "...Loading Sleep Data"
    
    var body: some View {
        VStack{
            Text(message)
            SleepChartView(sleepData: sleepData, dateStart: getStartDate(sleepData: sleepData), dateEnd: getEndDate(sleepData: sleepData))
        }
        .onAppear {
            fetchSleepDataForChart {
                (result, error) in
                sleepData = result
                message = "Sleep Data Loaded"
                if sleepData.isEmpty {
                    self.message = error?.localizedDescription ?? "Unknown error"
                }
            }
        }
        .padding()
    }
            
    func fetchSleepDataForChart(completion: @escaping ([HKCategorySample], Error?) -> Void) {
        sleepDataFetcher.requestAuthorization() {
            success in
            if success {
                sleepDataFetcher.fetchSleepData() {
                    (result, error) in
//                    printSleepData(sleepData: result)
                    completion(result, error)
                }
            }
        }
    }
    
    func printSleepData(sleepData: [HKCategorySample]) {
        for sample in sleepData {
            print("Sleep Analysis Sample:")
            print("Start Date: \(sample.startDate)")
            print("End Date: \(sample.endDate)")
            
            let sleepValue = sample.value
            switch sleepValue {
            case HKCategoryValueSleepAnalysis.inBed.rawValue:
                print("Sleep Status: In Bed")
            case HKCategoryValueSleepAnalysis.awake.rawValue:
                print("Sleep Status: Awake")
            case HKCategoryValueSleepAnalysis.asleepREM.rawValue:
                print("Sleep Status: REM")
            case HKCategoryValueSleepAnalysis.asleepCore.rawValue:
                print("Sleep Status: Core")
            case HKCategoryValueSleepAnalysis.asleepDeep.rawValue:
                print("Sleep Status: Deep")
            default:
                print("Unknown Sleep Status")
            }
        }
    }
    
    func getStartDate(sleepData: [HKCategorySample]) -> Date {
        // TODO: handle the empty case properly
        if sleepData.isEmpty {
            return Date()
        }
        
        var startDate = Date()
        for sample in sleepData {
            if sample.startDate < startDate {
                startDate = sample.startDate
            }
        }
        
        return startDate
    }
    
    func getEndDate(sleepData: [HKCategorySample]) -> Date {
        // TODO: handle the empty case properly
        if sleepData.isEmpty {
            return Date()
        }
        
        var endDate = Date(timeIntervalSince1970: 0)
        for sample in sleepData {
            if sample.endDate > endDate {
                endDate = sample.endDate
            }
        }
        
        return endDate
    }
}

struct SleepResultView_Previews: PreviewProvider {
    static var previews: some View {
        SleepResultView()
    }
}
