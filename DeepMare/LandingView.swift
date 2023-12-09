//
//  ContentView.swift
//  DeepMare
//
//  Created by Lin Fanshi on 9/12/23.
//

import SwiftUI

struct SleepResultView: View {
    var body: some View {
        VStack {
            Text("SleepResult")
            Text("SleepResult")
            Text("SleepResult")
            Text("SleepResult")
            Text("SleepResult")
        }
        .padding()
    }
}

struct SleepTestView: View {
    var body: some View {
        VStack {
            Text("SleepTest")
            Text("SleepTest")
            Text("SleepTest")
            Text("SleepTest")
            Text("SleepTest")
        }
        .padding()
    }
}


struct LandingView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    SleepResultView()
                } label: {
                    Text("Result")
                }

                NavigationLink {
                    SleepTestView()
                } label: {
                    Text("Test")
                }
            }
        }
        .padding()
    }
}

#Preview {
    LandingView()
}
