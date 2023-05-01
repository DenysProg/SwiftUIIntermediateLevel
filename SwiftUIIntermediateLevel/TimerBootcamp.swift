//
//  TimerBootcamp.swift
//  SwiftUIIntermediateLevel
//
//  Created by Denys Nikolaichuk on 19.04.2023.
//

import SwiftUI

struct TimerBootcamp: View {
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    // Current Time
    /*
     @State var currentDate: Date = Date()
     var dateFormatter: DateFormatter {
     let formatter = DateFormatter()
     formatter.timeStyle = .medium
     return formatter
     }
     */
    
    // Countdown
    /*
     @State var count: Int = 10
     @State var finishedText: String? = nil
     */
    
    // Countdown to date
    /*
     @State var timeRemaining: String = ""
     let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
     */
    
    // Animation counter
    @State var count: Int = 1
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))]),
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
            .ignoresSafeArea()
            //            Text(timeRemaining) // dateFormatter.string(from: currentDate) // finishedText ?? "\(count)"
            //                .font(.system(size: 100, weight: .semibold, design: .rounded))
            //                .foregroundColor(.white)
            //                .lineLimit(1)
            //                .minimumScaleFactor(0.1)
            
//            HStack(spacing: 15) {
//                Circle()
//                    .offset(y: count == 1 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 2 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 3 ? -20 : 0)
//            }
//            .frame(width: 200)
//            .foregroundColor(.white)
            
            TabView(selection: $count, content: {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
                .tableStyle(.automatic)
            })
            .frame(height: 200)
            .tabViewStyle(.page)
            
            
        }
        .onReceive(timer) { value in
            
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1
            }
            
            
            
            //            updateTimeRemaning()
            //            if count <= 1 {
            //                finishedText = "Wow"
            //            } else {
            //                count -= 1
            //            }
            //            currentDate = value
        }
    }
    
    //    func updateTimeRemaning() {
    //        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
    //        let hour = remaining.hour ?? 0
    //        let minute = remaining.minute ?? 0
    //        let second = remaining.second ?? 0
    //
    //        timeRemaining = "\(hour):\(minute):\(second)"
    //    }
    //}
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
