//
//  ContentView.swift
//  DeepMare
//
//  Created by Lin Fanshi on 9/12/23.
//

import SwiftUI

struct LandingView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Fetch Sleep Data", action: <#T##() -> Void#>)
        }
        .padding()
    }
}

#Preview {
    LandingView()
}
