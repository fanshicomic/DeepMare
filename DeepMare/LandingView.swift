//
//  ContentView.swift
//  DeepMare
//
//  Created by Lin Fanshi on 9/12/23.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    SleepResultView()
                } label: {
                    Text("👽睡眠結果👽")
                }.padding()

                NavigationLink {
                    SleepTestView()
                } label: {
                    Text("🪓睡眠測試🪓")
                }.padding()
            }
        }
    }
}

#Preview {
    LandingView()
}
