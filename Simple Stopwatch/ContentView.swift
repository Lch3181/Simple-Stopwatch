//
//  ContentView.swift
//  Simple Stopwatch
//
//  Created by Mitchell Lam on 3/31/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var stopwatch = Stopwatch()
    
    var body: some View {
        VStack(spacing: 100.0) {
            Text(String(format: "%.2f", stopwatch.timeElapsed))
                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            
            HStack {
                Spacer()
                Button(action: {
                    stopwatch.reset()
                }, label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(Color.white)
                        .frame(width: 50.0, height: 50.0)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
                        .cornerRadius(200.0)
                    
                })
                Spacer()
                switch stopwatch.mode {
                case .stopped:
                    withAnimation {
                        Button(action: {
                            stopwatch.start()
                        }, label: {
                            Image(systemName: "play.fill")
                                .foregroundColor(Color.white)
                                .frame(width: 50.0, height: 50.0)
                                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                                .cornerRadius(200.0)
                            
                        })
                        
                    }
                    
                case .running:
                    withAnimation {
                        Button(action: {
                            stopwatch.stop()
                        }, label: {
                            Image(systemName: "stop.fill")
                                .foregroundColor(Color.white)
                                .frame(width: 50.0, height: 50.0)
                                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.red/*@END_MENU_TOKEN@*/)
                                .cornerRadius(200.0)
                            
                        })
                    }
                }
                Spacer()
            }
        }
    }
}

enum mode {
    case running
    case stopped
}

class Stopwatch:ObservableObject {
    @Published var timeElapsed = 0.00
    @Published var mode:mode = .stopped
    var timer = Timer()
    
    func start() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {_ in
            self.timeElapsed += 0.01
        }
    }
    
    func stop() {
        timer.invalidate()
        mode = .stopped
    }
    
    func reset() {
        timer.invalidate()
        mode = .stopped
        timeElapsed = 0.00
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
