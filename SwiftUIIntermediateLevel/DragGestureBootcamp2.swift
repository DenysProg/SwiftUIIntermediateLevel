//
//  DragGestureBootcamp2.swift
//  SwiftUIIntermediateLevel
//
//  Created by Denys Nikolaichuk on 15.03.2023.
//

import SwiftUI

struct DragGestureBootcamp2: View {
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.87
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingDragOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            MySignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingDragOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        })
                    
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    endingDragOffsetY = -startingOffsetY
                                    currentDragOffsetY = 0
                                } else if endingDragOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingDragOffsetY = 0
                                    currentDragOffsetY = 0
                                }
                                currentDragOffsetY = 0
                            }
                        })
                )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DragGestureBootcamp2_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcamp2()
    }
}

struct MySignUpView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the description for our app. This is my favorite SwiftUi cource and I recommend to all of my friends to subscribe to Siftful Thinking")
                .multilineTextAlignment(.center)
            
            Text("Create an account")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(30)
    }
}
