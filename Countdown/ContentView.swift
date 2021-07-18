//
//  ContentView.swift
//  Countdown
//
//  Created by Alex Wang on 18/7/21.
//

import SwiftUI

let defaultTimeRemaining: CGFloat = 60
let lineWith: CGFloat = 30
let radius: CGFloat = 120

struct ContentView: View {
    
    @State private var isActive = false
    @State private var timeRemaining: CGFloat = defaultTimeRemaining
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 40) {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: lineWith, lineCap: .round))
                Circle()
                    .trim(from: 0, to: 1 - ((defaultTimeRemaining - timeRemaining) / defaultTimeRemaining))
                    .stroke(timeRemaining > 40 ? Color.green : timeRemaining > 20 ? Color.yellow : Color.red, style: StrokeStyle(lineWidth: lineWith, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut)
                VStack(spacing: -15){
                    Image("Atlas")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                    Text("\(Int(timeRemaining))").font(.system(size: 150)).foregroundColor(timeRemaining > 40 ? Color.green : timeRemaining > 20 ? Color.yellow : Color.red)
                }
                
            }.frame(width: radius * 3, height: radius * 3)
            
            HStack(spacing: 40) {
                Label("\(isActive ? "Pause" : "Play")", systemImage: "\(isActive ? "pause.fill" : "play.fill")").foregroundColor(isActive ? .red : .yellow).font(.system(size: 30)).onTapGesture(perform: {
                    isActive.toggle()
                })
                
                Label("Reset", systemImage: "goforward").foregroundColor(.blue).font(.system(size: 30)).onTapGesture(perform: {
//                    isActive = false
                    timeRemaining = defaultTimeRemaining
                })
            }
        }.onReceive(timer, perform: { _ in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isActive = false
                timeRemaining = defaultTimeRemaining
            }
        }).frame(width: 450.0, height: 500.0)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 600.0, height: 650.0)
    }
}

