//
//  MultipleSheetsBootcamp.swift
//  SwiftUIIntermediateLevel
//
//  Created by Denys Nikolaichuk on 15.03.2023.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

// 1 - use a binding          @Binding var selected: RandomModel
// 2 - use multiple .shets
// 3 - use $item

struct MultipleSheetsBootcamp: View {
    @State var selectedModel: RandomModel? = nil
    
    // 1 2
//    @State var showSheet: Bool = false
//    @State var showSheet2: Bool = false
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 20) {
                ForEach(0..<20) { index in
                    Button("Button \(index)") {
                        // 1
                        selectedModel = RandomModel(title: "\(index)")
                        //                showSheet.toggle()
                    }
                }
                
                
                //            Button("Button 1") {
                //                // 1
                //                selectedModel = RandomModel(title: "One")
                ////                showSheet.toggle()
                //            }
                
                // 2
                //            .sheet(isPresented: $showSheet) {
                //                NextScreen(selected: RandomModel(title: "One"))
                //            }
                
                //            Button("Button 2") {
                //                // 1
                //                selectedModel = RandomModel(title: "Two")
                ////                showSheet.toggle()
                ////                showSheet2.toggle()
                //            }
                // 2
                //            .sheet(isPresented: $showSheet2) {
                //                NextScreen(selected: RandomModel(title: "Two"))
                //            }
            }
            
            .sheet(item: $selectedModel) { model in
                NextScreen(selected: model)
            }
        }
        
        // 1
//        .sheet(isPresented: $showSheet) {
//            NextScreen(selected: selectedModel)
//        }
    }
}

struct NextScreen: View {
    
    // 1
//    @Binding var selected: RandomModel
    
    let selected: RandomModel
    
    var body: some View {
        Text(selected.title)
            .font(.largeTitle)
    }
}

struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
