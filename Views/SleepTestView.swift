//
//  SleepTestView.swift
//  DeepMare
//
//  Created by Mingyu Lei on 2023/12/09.
//

import SwiftUI
import AVKit

struct SleepTestView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State var audioPlayer: AVAudioPlayer!

    var body: some View {
        VStack {
            Text("\(speechRecognizer.result ? "💩你真棒💩" : "重复你听到的最后一个词")")
        }
        .padding()
        .onAppear() {
            let sound = Bundle.main.url(forResource: "盘旋", withExtension: "mp3")!
            self.audioPlayer = try! AVAudioPlayer(contentsOf: sound)
            self.audioPlayer.play()
            // Hack
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                speechRecognizer.startTranscribing()
            }
        }
    }
}

#Preview {
    SleepTestView()
}
