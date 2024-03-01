//
//  SleepChartView.swift
//  DeepMare
//
//  Created by Lin Fanshi on 21/12/23.
//

import SwiftUI
import Foundation
import HealthKit
import Charts

struct SleepChartView: View {
    let sleepData: [HKCategorySample]
    let dateStart, dateEnd: Date
    var body: some View {
        VStack{
            LineChart(dataPoints: computeSegments()).frame(height: 500)
        }
        .padding()
    }
    
//    func computeCoords() -> [CGPoint] {
//        var result: [CGPoint] = []
//        
//        for sample in sleepData {
//            let y = mapSleepStatusToY(status: sample.value)
//            
//            if y != 0 {
//                let xStart = mapDateToX(date: sample.startDate)
//                let xEnd = mapDateToX(date: sample.endDate)
//                
//                result.append(CGPoint(x: xStart, y: CGFloat(y)))
//                result.append(CGPoint(x: xEnd, y: CGFloat(y)))
//            }
//        }
//        
//        print(result)
//        return result
//    }
    
    func computeSegments() -> [Segment] {
        var result: [Segment] = []
        var i = 0
    
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        
        for sample in sleepData {
            let y = mapSleepStatusToY(status: sample.value)
            
            if y != 0 {
                let convertedStartDate = calendar.date(from: calendar.dateComponents(in: calendar.timeZone, from: sample.startDate))!
                let convertedEndDate = calendar.date(from: calendar.dateComponents(in: calendar.timeZone, from: sample.endDate))!
                
                result.append(Segment(x: convertedStartDate, y: y, id: i))
                result.append(Segment(x: convertedEndDate, y: y, id: i))
                
                i += 1
            }
        }
        
//        print(result)
        return result
    }
    
    func mapDateToX(date: Date) -> Double {
        if sleepData.isEmpty {
            return 0
        }
        
        let dateRange = dateEnd.timeIntervalSince(dateStart)
        let x = Double(date.timeIntervalSince(dateStart)) / CGFloat(dateRange)
        return x
    }
    
    func mapSleepStatusToY(status: Int) -> Int {
        switch status {
        case HKCategoryValueSleepAnalysis.awake.rawValue:
            return 4
        case HKCategoryValueSleepAnalysis.asleepREM.rawValue:
            return 3
        case HKCategoryValueSleepAnalysis.asleepCore.rawValue:
            return 2
        case HKCategoryValueSleepAnalysis.asleepDeep.rawValue:
            return 1
        default:
            return 0
        }
    }

}

