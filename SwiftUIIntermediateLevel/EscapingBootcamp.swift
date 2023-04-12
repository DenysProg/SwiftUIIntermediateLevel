//
//  EscapingBootcamp.swift
//  SwiftUIIntermediateLevel
//
//  Created by Denys Nikolaichuk on 12.04.2023.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    @Published var text: String = "Hello"
    
    func getData() {
//        downloadData3 { [weak self] data in
//            self?.text = data.data
//        }
        
        downloadData4 { [weak self] data in
            self?.text = data.data
        }
    }
    
    func downloadData() -> String {
        return "New Data"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> Void) {
       completionHandler("New data!")
    }
    
    func downloadData3(completionHandler: @escaping (DataResult) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New data!")
            completionHandler(result)
        }
    }
    
    func downloadData4(completionHandler: @escaping DownloadCompletion) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New data!")
            completionHandler(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DataResult = DownloadResult
typealias DownloadCompletion = (DownloadResult) -> Void

struct EscapingBootcamp: View {
    @StateObject var viewModel = EscapingViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.blue)
            .onTapGesture {
                viewModel.getData()
            }
    }
}

struct EscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootcamp()
    }
}
