//
//  DownloadingImagesBootcamp.swift
//  SwiftUIIntermediateLevel
//
//  Created by Denys Nikolaichuk on 01.05.2023.
//

import SwiftUI

struct DownloadingImagesBootcamp: View {
    @StateObject var viewModel = DownloadingImagesViewModel()
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(viewModel.dataArray) { model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading images")
        }
    }
}

struct DownloadingImagesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesBootcamp()
    }
}
