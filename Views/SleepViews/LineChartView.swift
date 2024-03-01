//
//  LineChartView.swift
//  DeepMare
//
//  Created by Lin Fanshi on 22/12/23.
//

import SwiftUI
import HealthKit
import Charts

struct Segment: Identifiable {
    let x: Date
    let y: Int
    
    let id: Int
}

struct LineChart: View {
    let dataPoints: [Segment]
    
    var body: some View {
        Chart(dataPoints) {
            LineMark(x: .value("Time", $0.x), y: .value("Status", $0.y))
        }
        .chartYScale(domain: [1, 4])
        .chartYAxis {
            AxisMarks(
                format: sleepStatusAxisFormatter(),
                values: [1,2,3,4]
            )
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .hour, count: 2)) { value in
                if let date = value.as(Date.self) {
                    let hour = Calendar.current.component(.hour, from: date)
                    switch hour {
                    case 0, 12:
                        AxisValueLabel(format: .dateTime.hour())
                    default:
                        AxisValueLabel(format: .dateTime.hour(.defaultDigits(amPM: .omitted)))
                    }
                    
                    AxisGridLine()
                    AxisTick()
                }
            }
        }
    }
    
    struct sleepStatusAxisFormatter: FormatStyle {
        func format(_ value: Int) -> String {
            guard let intValue = Int(value.description) else { return "Invalid" }
            switch intValue {
            case 1:
                return "Deep"
            case 2:
                return "Core"
            case 3:
                return "REM"
            case 4:
                return "Awake"
            default:
                return "Unknown"
            }
        }
    }
}

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        let dataPoints = [DeepMare.Segment(x: formattedDate(date: "2024-02-28 19:20:10 +0000"), y: 2, id: 0), DeepMare.Segment(x: formattedDate(date: "2024-02-28 19:49:10 +0000"), y: 2, id: 0), DeepMare.Segment(x: formattedDate(date: "2024-02-28 19:49:10 +0000"), y: 1, id: 1), DeepMare.Segment(x: formattedDate(date: "2024-02-28 20:08:40 +0000"), y: 1, id: 1), DeepMare.Segment(x: formattedDate(date: "2024-02-28 20:08:40 +0000"), y: 2, id: 2), DeepMare.Segment(x: formattedDate(date: "2024-02-28 20:13:40 +0000"), y: 2, id: 2), DeepMare.Segment(x: formattedDate(date: "2024-02-28 20:13:40 +0000"), y: 3, id: 3), DeepMare.Segment(x: formattedDate(date: "2024-02-28 20:27:10 +0000"), y: 3, id: 3), DeepMare.Segment(x: formattedDate(date: "2024-02-28 20:27:10 +0000"), y: 2, id: 4), DeepMare.Segment(x: formattedDate(date: "2024-02-28 20:49:40 +0000"), y: 2, id: 4), DeepMare.Segment(x: formattedDate(date: "2024-02-28 20:49:40 +0000"), y: 1, id: 5), DeepMare.Segment(x: formattedDate(date: "2024-02-28 21:01:40 +0000"), y: 1, id: 5), DeepMare.Segment(x: formattedDate(date: "2024-02-28 21:01:40 +0000"), y: 2, id: 6), DeepMare.Segment(x: formattedDate(date: "2024-02-28 21:16:10 +0000"), y: 2, id: 6), DeepMare.Segment(x: formattedDate(date: "2024-02-28 21:16:10 +0000"), y: 1, id: 7), DeepMare.Segment(x: formattedDate(date: "2024-02-28 21:36:40 +0000"), y: 1, id: 7), DeepMare.Segment(x: formattedDate(date: "2024-02-28 21:36:40 +0000"), y: 2, id: 8), DeepMare.Segment(x: formattedDate(date: "2024-02-28 21:41:40 +0000"), y: 2, id: 8), DeepMare.Segment(x: formattedDate(date: "2024-02-28 21:41:40 +0000"), y: 3, id: 9), DeepMare.Segment(x: formattedDate(date: "2024-02-28 22:15:10 +0000"), y: 3, id: 9), DeepMare.Segment(x: formattedDate(date: "2024-02-28 22:15:10 +0000"), y: 2, id: 10), DeepMare.Segment(x: formattedDate(date: "2024-02-28 23:21:10 +0000"), y: 2, id: 10), DeepMare.Segment(x: formattedDate(date: "2024-02-28 23:21:10 +0000"), y: 3, id: 11), DeepMare.Segment(x: formattedDate(date: "2024-02-28 23:47:10 +0000"), y: 3, id: 11), DeepMare.Segment(x: formattedDate(date: "2024-02-28 23:47:10 +0000"), y: 4, id: 12), DeepMare.Segment(x: formattedDate(date: "2024-02-28 23:52:40 +0000"), y: 4, id: 12), DeepMare.Segment(x: formattedDate(date: "2024-02-28 23:52:40 +0000"), y: 2, id: 13)]
        
        LineChart(dataPoints: dataPoints).frame(width: 300, height: 400)
    }
}

func formattedDate(date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    return dateFormatter.date(from: date)!
}
